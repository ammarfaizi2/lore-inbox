Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750898AbWDVShA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750898AbWDVShA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 14:37:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750906AbWDVShA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 14:37:00 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:31149 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1750898AbWDVSg6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 14:36:58 -0400
Subject: Re: kfree(NULL)
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Paul Mackerras <paulus@samba.org>
Cc: Andrew Morton <akpm@osdl.org>, James Morris <jmorris@namei.org>,
       dwalker@mvista.com, linux-kernel@vger.kernel.org
In-Reply-To: <17481.60890.127240.334557@cargo.ozlabs.ibm.com>
References: <200604210703.k3L73VZ6019794@dwalker1.mvista.com>
	 <Pine.LNX.4.64.0604210322110.21429@d.namei>
	 <20060421015412.49a554fa.akpm@osdl.org>
	 <17481.28892.506618.865014@cargo.ozlabs.ibm.com>
	 <84144f020604220043i65502955ha6dc2759d8cd665b@mail.gmail.com>
	 <17481.60890.127240.334557@cargo.ozlabs.ibm.com>
Date: Sat, 22 Apr 2006 18:02:29 +0300
Message-Id: <1145718150.11295.15.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-04-22 at 18:48 +1000, Paul Mackerras wrote:
> There is a judgement to be made at each call site of kfree (and
> similar functions) about whether the argument is rarely NULL, or could
> often be NULL.  If the janitors have been making this judgement, I
> apologise, but I haven't seen them doing that.

I don't think anyone should be calling kfree with NULL pointer often in
the first place. Keeping the extra check in place is masking the real
problem. So yeah, we should be looking at the NULL checks more carefully
to see if they require more fundamental fixes, but no, I don't see why
janitors can't continue to remove the extra checks.

				Pekka

