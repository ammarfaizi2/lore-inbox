Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932442AbWJ3Ljg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932442AbWJ3Ljg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 06:39:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932444AbWJ3Ljg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 06:39:36 -0500
Received: from cacti.profiwh.com ([85.93.165.66]:36487 "EHLO cacti.profiwh.com")
	by vger.kernel.org with ESMTP id S932442AbWJ3Ljg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 06:39:36 -0500
Message-ID: <4545E471.7080906@gmail.com>
Date: Mon, 30 Oct 2006 12:39:29 +0100
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Andrew Paprocki <andrew@ishiboo.com>
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] Fixed uninitialized variable warning in drivers/md/dm-exception-store.c.
References: <76366b180610292108o62b0b480v91356fb957fbebcc@mail.gmail.com>
In-Reply-To: <76366b180610292108o62b0b480v91356fb957fbebcc@mail.gmail.com>
X-Enigmail-Version: 0.94.1.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Paprocki wrote:
> Fixed uninitialized variable warning in drivers/md/dm-exception-store.c.
> 
> Signed-off-by: Andrew Paprocki <andrew@ishiboo.com>
> 
> ---
> drivers/md/dm-exception-store.c |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/md/dm-exception-store.c
> b/drivers/md/dm-exception-store.c
> index 99cdffa..d50ffde 100644
> --- a/drivers/md/dm-exception-store.c
> +++ b/drivers/md/dm-exception-store.c
> @@ -413,7 +413,7 @@ static void persistent_destroy(struct ex
> 
> static int persistent_read_metadata(struct exception_store *store)
> {
> -       int r, new_snapshot;
> +       int r, new_snapshot = 0;
>        struct pstore *ps = get_info(store);
> 
>        /*

Already in -mm.

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
