Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267725AbUIOXdR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267725AbUIOXdR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 19:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267720AbUIOX3Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 19:29:16 -0400
Received: from holomorphy.com ([207.189.100.168]:63391 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267774AbUIOX16 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 19:27:58 -0400
Date: Wed, 15 Sep 2004 16:27:51 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Albert Cahalan <albert@users.sf.net>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>, ak@muc.de
Subject: Re: get_current is __pure__, maybe __const__ even
Message-ID: <20040915232751.GD9106@holomorphy.com>
References: <1095288600.1174.5968.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095288600.1174.5968.camel@cube>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen writes:
>> Please CSE "current" manually. It generates
>> much better code on some architectures
>> because the compiler cannot do it for you.

On Wed, Sep 15, 2004 at 06:50:00PM -0400, Albert Cahalan wrote:
> This looks fixable.
> At the very least, __attribute__((__pure__))
> will apply to your get_current function.
> I think __attribute__((__const__)) will too,
> even though it's technically against the
> documentation. While you do indeed read from
> memory, you don't read from memory that could
> be seen as changing. Nothing done during the
> lifetime of a task will change "current" as
> viewed from within that task.

The fix needs to be made to gcc, not the kernel.


-- wli
