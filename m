Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268135AbUIWRly@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268135AbUIWRly (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 13:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268223AbUIWRkA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 13:40:00 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29892 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268135AbUIWRj2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 13:39:28 -0400
Date: Thu, 23 Sep 2004 18:39:27 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Albert Cahalan <albert@users.sf.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       rth@twiddle.net
Subject: Re: __attribute__((always_inline)) fiasco
Message-ID: <20040923173927.GO23987@parcelfarce.linux.theplanet.co.uk>
References: <1095956778.4966.940.camel@cube> <20040923165026.GF9106@holomorphy.com> <20040923172104.GN23987@parcelfarce.linux.theplanet.co.uk> <20040923173315.GG9106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040923173315.GG9106@holomorphy.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2004 at 10:33:15AM -0700, William Lee Irwin III wrote:
> On Thu, Sep 23, 2004 at 09:50:26AM -0700, William Lee Irwin III wrote:
> >> The // apart from being a C++ ism (screw C99; it's still non-idiomatic)
> >> will cause spurious ignorance of the remainder of the line, which is
> 
> On Thu, Sep 23, 2004 at 06:21:04PM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> > Usual Albert's taste level aside, you are wrong.  Comments are replaced
> > with whitespace on phase 3 (tokenizer) and preprocessor lives on phase 4.
> > IOW, that // will never be seen by preprocessor.
> 
> I'll be sure to put this on file with the rest of the numerous "while
> legal in C, never *EVER* do this" oddities.

Huh?  Comments (all sorts of comments) are dealt with before you get to
preprocessing.  Which *is* the right behaviour - anything else would be
much, much messier.  What's the problem with that?
