Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262224AbVCCUAO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262224AbVCCUAO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 15:00:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262162AbVCCTwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 14:52:34 -0500
Received: from smtp-out.hotpop.com ([38.113.3.61]:12484 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP id S261720AbVCCTvF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 14:51:05 -0500
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: Adrian Bunk <bunk@stusta.de>, adaplas@pol.net
Subject: Re: RFC: disallow modular framebuffers
Date: Fri, 4 Mar 2005 03:50:42 +0800
User-Agent: KMail/1.5.4
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20050301024118.GF4021@stusta.de> <200503012115.29023.adaplas@hotpop.com> <20050303165649.GF4608@stusta.de>
In-Reply-To: <20050303165649.GF4608@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503040350.51163.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 04 March 2005 00:56, Adrian Bunk wrote:
> On Tue, Mar 01, 2005 at 09:15:27PM +0800, Antonino A. Daplas wrote:
> > On Tuesday 01 March 2005 10:41, Adrian Bunk wrote:
> > > Hi,
> > >
> > > while looking how to fix modular FB_SAVAGE_* (both FB_SAVAGE_I2C=m and
> > > FB_SAVAGE_ACCEL=m are currently broken) I asked myself:
> >
> > BTW, what's the problem with the above?
>
>   #if defined(CONFIG_FB_SAVAGE_ACCEL)
>
> doesn't work with FB_SAVAGE_ACCEL=m, and
>
>   #if defined(CONFIG_FB_SAVAGE_ACCEL) ||
> defined(CONFIG_FB_SAVAGE_ACCEL_MODULE)
>
> would break with FB_SAVAGE=y and FB_SAVAGE_ACCEL=m.
>

I see.

>
> Is there any reason for these being three modules?
> It seems the best solution would be to make this one module composed of
> up to three object files?

Yes.

Tony


