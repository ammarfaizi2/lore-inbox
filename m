Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262587AbVDYM0y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262587AbVDYM0y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 08:26:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262592AbVDYM0y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 08:26:54 -0400
Received: from thunk.org ([69.25.196.29]:8354 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S262587AbVDYM0m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 08:26:42 -0400
Date: Mon, 25 Apr 2005 07:57:50 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Bernd Eckenfels <be-mail2005@lina.inka.de>
Cc: Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: more git updates..
Message-ID: <20050425115750.GA11233@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Bernd Eckenfels <be-mail2005@lina.inka.de>,
	Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org
References: <20050423174227.51360d63.pj@sgi.com> <E1DPVwN-0007pj-00@calista.eckenfels.6bone.ka-ip.net> <20050423211326.7ed8e199.pj@sgi.com> <20050424043813.GA2422@lina.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050424043813.GA2422@lina.inka.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 24, 2005 at 06:38:13AM +0200, Bernd Eckenfels wrote:
> On Sat, Apr 23, 2005 at 09:13:26PM -0700, Paul Jackson wrote:
> > I don't believe you.  Reference?
> 
> I had MD5 in mind, sorry. I havent seen the SHA-1 colision samples, yet.
> However it is likely to be available soon. (a simple pair with two files
> will be enugh to cause "theoretical" problems. However I think it would be
> possible to detect collisions on add and append sequence numbers... ugly.

The MD5 collision smaples are for two 16 byte inputs which when run
through the MD5 algorithm, result in the same 128-bit hash.  The SHA-1
collision samples are for two 20 byte inputs which when run through
the SHA algorithm create the same 160-bit hash.  In neither case will
the inputs be valid git objects, nor anything approaching ASCII text,
let alone valid C files.  

So what theoretical problems will be caused by this?  Sure, an
attacker can check a garbage file containing (apparently) random bytes
into git, and then produce another garbage file containing some
completely other (apparently) random bytes which will collide with the
first garbage file.  

You want to explain how this is going to cause problems in the git
systems?  And even if you can describe any problems, you want to
explain why any such theoretical problems couldn't be trivially
detected and fixed?

						- Ted
