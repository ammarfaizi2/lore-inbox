Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264418AbTLVPAj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 10:00:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264419AbTLVPAj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 10:00:39 -0500
Received: from holomorphy.com ([199.26.172.102]:52896 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264418AbTLVPAh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 10:00:37 -0500
Date: Mon, 22 Dec 2003 07:00:26 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Albert Cahalan <albert@users.sf.net>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: atomic copy_from_user?
Message-ID: <20031222150026.GD27687@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Albert Cahalan <albert@users.sf.net>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>
References: <1072054100.1742.156.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1072054100.1742.156.camel@cube>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 21, 2003 at 07:48:20PM -0500, Albert Cahalan wrote:
> Surely I'm not the only one wanting such a beast...?
> From some naughty place in the code where might_sleep
> would trigger, I'd like to read from user memory.
> I'll pretty much assume that mlockall() has been
> called. Suppose that "current" is correct as well.
> I'd just use a pointer directly, except that:
> a. it isn't OK for the 4g/4g feature, s390, or sparc64
> b. it causes the "sparse" type checker to complain
> c. it will oops or worse if the user screwed up
> If the page is swapped out, I want a failed copy.

c.f. kmap_atomic() usage in mm/filemap.c


-- wli
