Return-Path: <linux-kernel-owner+w=401wt.eu-S1751141AbXAPNFq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbXAPNFq (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 08:05:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbXAPNFq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 08:05:46 -0500
Received: from mx1.suse.de ([195.135.220.2]:56022 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751141AbXAPNFp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 08:05:45 -0500
Date: Tue, 16 Jan 2007 14:05:44 +0100
From: Karsten Keil <kkeil@suse.de>
To: "Ahmed S. Darwish" <darwish.07@gmail.com>
Cc: kai.germaschewski@gmx.de, linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: Re: [PATCH 2.6.20-rc5] isdn/capi: use ARRAY_SIZE when appropriate
Message-ID: <20070116130544.GA18190@pingi.kke.suse.de>
Mail-Followup-To: "Ahmed S. Darwish" <darwish.07@gmail.com>,
	kai.germaschewski@gmx.de, linux-kernel@vger.kernel.org,
	trivial@kernel.org
References: <20070116095319.GB718@Ahmed>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070116095319.GB718@Ahmed>
Organization: SuSE Linux AG
X-Operating-System: Linux 2.6.16.21-0.23-smp x86_64
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 16, 2007 at 11:53:19AM +0200, Ahmed S. Darwish wrote:
> Hi all,
> 
> A trivial patch to use ARRAY_SIZE macro defined in kernel.h instead
> of reimplementing it.
> 
> Signed-off-by: Ahmed S. Darwish <darwish.07@gmail.com>

Acked-by: Karsten Keil <kkeil@suse.de>

> ---
> 
> capi.c    |    4 ++--
> capidrv.c |    4 ++--
> 2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/isdn/capi/capi.c b/drivers/isdn/capi/capi.c
> index d22c022..3804591 100644
> --- a/drivers/isdn/capi/capi.c
> +++ b/drivers/isdn/capi/capi.c
> @@ -1456,7 +1456,7 @@ static struct procfsentries {
>  
>  static void __init proc_init(void)
>  {
> -    int nelem = sizeof(procfsentries)/sizeof(procfsentries[0]);
> +    int nelem = ARRAY_SIZE(procfsentries);
>      int i;
>  
>      for (i=0; i < nelem; i++) {
> @@ -1468,7 +1468,7 @@ static void __init proc_init(void)
>  
>  static void __exit proc_exit(void)
>  {
> -    int nelem = sizeof(procfsentries)/sizeof(procfsentries[0]);
> +    int nelem = ARRAY_SIZE(procfsentries);
>      int i;
>  
>      for (i=nelem-1; i >= 0; i--) {
> diff --git a/drivers/isdn/capi/capidrv.c b/drivers/isdn/capi/capidrv.c
> index c4d438c..8cec9c3 100644
> --- a/drivers/isdn/capi/capidrv.c
> +++ b/drivers/isdn/capi/capidrv.c
> @@ -2218,7 +2218,7 @@ static struct procfsentries {
>  
>  static void __init proc_init(void)
>  {
> -    int nelem = sizeof(procfsentries)/sizeof(procfsentries[0]);
> +    int nelem = ARRAY_SIZE(procfsentries);
>      int i;
>  
>      for (i=0; i < nelem; i++) {
> @@ -2230,7 +2230,7 @@ static void __init proc_init(void)
>  
>  static void __exit proc_exit(void)
>  {
> -    int nelem = sizeof(procfsentries)/sizeof(procfsentries[0]);
> +    int nelem = ARRAY_SIZE(procfsentries);
>      int i;
>  
>      for (i=nelem-1; i >= 0; i--) {
> 
> -- 
> Ahmed S. Darwish
> http://darwish-07.blogspot.com

-- 
Karsten Keil
SuSE Labs
ISDN development
