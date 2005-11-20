Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932069AbVKTTM2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbVKTTM2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 14:12:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932068AbVKTTM2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 14:12:28 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:20445 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S932065AbVKTTM1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 14:12:27 -0500
Subject: Re: [PATCH 4/12: eCryptfs] Main module functions
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Phillip Hellewell <phillip@hellewell.homeip.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       viro@ftp.linux.org.uk, mike@halcrow.us, mhalcrow@us.ibm.com,
       mcthomps@us.ibm.com, yoder1@us.ibm.com
In-Reply-To: <Pine.LNX.4.64.0511201531010.20876@hermes-1.csi.cam.ac.uk>
References: <20051119041130.GA15559@sshock.rn.byu.edu>
	 <20051119041740.GD15747@sshock.rn.byu.edu>
	 <84144f020511190247n5cf17800lb4ff019aa406470@mail.gmail.com>
	 <Pine.LNX.4.64.0511201531010.20876@hermes-1.csi.cam.ac.uk>
Date: Sun, 20 Nov 2005 21:06:56 +0200
Message-Id: <1132513616.8032.3.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anton,

On 11/19/05, Phillip Hellewell <phillip@hellewell.homeip.net> wrote:
> > > +                       BUG();
> > > +                       err = -EINVAL;
> > > +                       goto out;

On Sat, 19 Nov 2005, Pekka Enberg wrote:
> > Why do you want to BUG() and then handle the situation?

On Sun, 2005-11-20 at 15:34 +0000, Anton Altaparmakov wrote:
> Because you can define BUG() to nothing (on embedded builds for example) 
> and then you would be screwed if you don't handle the error gracefully.  
> You should never assume something does not return, except perhaps a 
> panic() although someone might even get rid of that one day...

You have a point but in this case, I don't understand why they don't
just handle it gracefully since they clearly can do so. Also, I was
under the impression that people who disable BUG() are knowingly taking
the risk...

			Pekka

