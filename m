Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312938AbSDMI5h>; Sat, 13 Apr 2002 04:57:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313482AbSDMI5g>; Sat, 13 Apr 2002 04:57:36 -0400
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:9993 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S312938AbSDMI5g>; Sat, 13 Apr 2002 04:57:36 -0400
Date: Sat, 13 Apr 2002 09:57:28 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Brian Gerst <bgerst@didntduck.org>
Cc: blesson paul <blessonpaul@msn.com>, linux-kernel@vger.kernel.org
Subject: Re: put_user_byte()
Message-ID: <20020413095728.A19090@flint.arm.linux.org.uk>
In-Reply-To: <F38uSbh29cM3oryKFRJ00031d09@hotmail.com> <3CB56D05.6040702@didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2002 at 07:01:25AM -0400, Brian Gerst wrote:
> Use put_user(val, uaddr).

Correct.

> val must be of type unsigned char (or casted to it).

put_user does not care what value you pass it as val.  It only cares
about the type of uaddr.  The following are all equivalent as far as
the size of the data type written to user space:

	put_user((int)foo, (char *)bar);
	put_user((char)foo, (char *)bar);
	put_user((long)foo, (char *)bar);

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

