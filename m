Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261308AbVAWOxF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261308AbVAWOxF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 09:53:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261310AbVAWOxF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 09:53:05 -0500
Received: from ra.tuxdriver.com ([24.172.12.4]:264 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S261308AbVAWOxC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 09:53:02 -0500
Date: Sun, 23 Jan 2005 09:48:59 -0500
From: "John W. Linville" <linville@tuxdriver.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch 2.4.29] i810_audio: offset LVI from CIV to avoid stalled start
Message-ID: <20050123144856.GA28932@tuxdriver.com>
Mail-Followup-To: Herbert Xu <herbert@gondor.apana.org.au>,
	linux-kernel@vger.kernel.org
References: <20050120202258.GA7687@tuxdriver.com> <20050120210739.GC7687@tuxdriver.com> <20050120212346.GD7687@tuxdriver.com> <20050120220120.GF7687@tuxdriver.com> <20050120220713.GA16599@gondor.apana.org.au> <20050122030258.GA776@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050122030258.GA776@gondor.apana.org.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 22, 2005 at 02:02:58PM +1100, Herbert Xu wrote:
> On Fri, Jan 21, 2005 at 09:07:13AM +1100, herbert wrote:
> > On Thu, Jan 20, 2005 at 05:01:21PM -0500, John W. Linville wrote:
> > > On Thu, Jan 20, 2005 at 04:23:46PM -0500, John W. Linville wrote:

> > > > +	 * the next sg segment, it won't even get a start.  So, instead, when
> > > > +	 * we are stopped, we increment the CIV value to the next sg segment
> > > > +	 * to be played so that when we call start, things will operate
> > > > +	 * properly
> > > > +	 */

> OK I dug into the archives and found that the reason we need to do
> it this way is because you can't set the value of CIV directly.  So
> how about s/CIV/LVI/ in the last sentence?

Herbert,

Agreed...I will post a patch to that effect shortly...

John
-- 
John W. Linville
linville@tuxdriver.com
