Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318881AbSHSQu2>; Mon, 19 Aug 2002 12:50:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318932AbSHSQu2>; Mon, 19 Aug 2002 12:50:28 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:34832 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318881AbSHSQu2>; Mon, 19 Aug 2002 12:50:28 -0400
Date: Mon, 19 Aug 2002 17:54:29 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, viro@math.psu.edu
Subject: Re: klibc and logging
Message-ID: <20020819175429.C17471@flint.arm.linux.org.uk>
References: <3D58B14A.5080500@zytor.com> <20020819142734.B17471@flint.arm.linux.org.uk> <3D60F9A6.6020304@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D60F9A6.6020304@zytor.com>; from hpa@zytor.com on Mon, Aug 19, 2002 at 06:59:02AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2002 at 06:59:02AM -0700, H. Peter Anvin wrote:
> I really think this is a bad idea.  The kmsg device has different 
> properties -- for example, you're supposed to tag things with the 
> message importance.  It really matches the syslog(3) interface better. 
> Also, the special case makes me nervous.

Without something like this, it means that effectively the "echo" command
wouldn't be useable, or you'd have to pipe the output of all scripts
through some program/to /dev/kmsg.

Or we just forget logging the messages from initramfs scripts.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

