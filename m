Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313508AbSDQKuO>; Wed, 17 Apr 2002 06:50:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313509AbSDQKuN>; Wed, 17 Apr 2002 06:50:13 -0400
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:60687 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S313508AbSDQKuN>; Wed, 17 Apr 2002 06:50:13 -0400
Date: Wed, 17 Apr 2002 11:50:06 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.8: Preempt problems
Message-ID: <20020417115006.E2386@flint.arm.linux.org.uk>
In-Reply-To: <20020417114331.D2386@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2002 at 11:43:31AM +0100, Russell King wrote:
> Comments?  Is there some fiddle in the x86 code somewhere that we've
> missed in the ARM tree to get this to work?

Appologies - just found the problem.  We were missing the call to
schedule_tail() after a fork.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

