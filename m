Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946399AbWJ0LPV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946399AbWJ0LPV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 07:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946402AbWJ0LPV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 07:15:21 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:54569 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1946401AbWJ0LPS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 07:15:18 -0400
In-Reply-To: <20061026201313.9c831fc9.akpm@osdl.org>
Subject: Re: [PATCH 2.6.19-rc3 1/2] ehea: kzalloc GFP_ATOMIC fix
To: Andrew Morton <akpm@osdl.org>
Cc: Jan-Bernd Themann <themann@de.ibm.com>, Jeff Garzik <jeff@garzik.org>,
       "linux-kernel" <linux-kernel@vger.kernel.org>,
       "linux-ppc" <linuxppc-dev@ozlabs.org>, Marcus Eder <meder@de.ibm.com>,
       netdev <netdev@vger.kernel.org>, ossthema@de.ibm.com,
       Thomas Q Klein <tklein@de.ibm.com>
X-Mailer: Lotus Notes Release 7.0 HF277 June 21, 2006
Message-ID: <OF9B06F6DE.7191F185-ONC1257214.003DB403-C1257214.003DD10C@de.ibm.com>
From: Christoph Raisch <RAISCH@de.ibm.com>
Date: Fri, 27 Oct 2006 13:17:51 +0200
X-MIMETrack: Serialize by Router on D12ML067/12/M/IBM(Release 6.5.5HF607 | June 26, 2006) at
 27/10/2006 13:18:00
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew Morton <akpm@osdl.org> wrote on 27.10.2006 05:13:13:

> On Wed, 25 Oct 2006 13:11:42 +0200
> Jan-Bernd Themann <ossthema@de.ibm.com> wrote:
>
> > This patch fixes kzalloc parameters (GFP_ATOMIC instead of GFP_KERNEL)
>
> why?


these few kcallocs run in atomic context in some situations.
therefore GFP_KERNEL is no good idea.

Christoph R.

