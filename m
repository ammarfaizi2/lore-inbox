Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268019AbUIWRWp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268019AbUIWRWp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 13:22:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268176AbUIWRVn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 13:21:43 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22467 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268191AbUIWRVG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 13:21:06 -0400
Date: Thu, 23 Sep 2004 18:21:04 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Albert Cahalan <albert@users.sf.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       rth@twiddle.net
Subject: Re: __attribute__((always_inline)) fiasco
Message-ID: <20040923172104.GN23987@parcelfarce.linux.theplanet.co.uk>
References: <1095956778.4966.940.camel@cube> <20040923165026.GF9106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040923165026.GF9106@holomorphy.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2004 at 09:50:26AM -0700, William Lee Irwin III wrote:
> > #define INLINE static inline  // an oxymoron
> 
> The // apart from being a C++ ism (screw C99; it's still non-idiomatic)
> will cause spurious ignorance of the remainder of the line, which is

Usual Albert's taste level aside, you are wrong.  Comments are replaced
with whitespace on phase 3 (tokenizer) and preprocessor lives on phase 4.
IOW, that // will never be seen by preprocessor.
