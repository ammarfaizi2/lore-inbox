Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130537AbRBTUFl>; Tue, 20 Feb 2001 15:05:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130308AbRBTUFY>; Tue, 20 Feb 2001 15:05:24 -0500
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:56845 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S130588AbRBTUFJ>; Tue, 20 Feb 2001 15:05:09 -0500
Date: Tue, 20 Feb 2001 21:04:37 +0100
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: hiren_mehta@agilent.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: can somebody explain barrier() macro ?
Message-ID: <20010220210437.A20058@arthur.ubicom.tudelft.nl>
In-Reply-To: <FEEBE78C8360D411ACFD00D0B74779718809AB@xsj02.sjs.agilent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <FEEBE78C8360D411ACFD00D0B74779718809AB@xsj02.sjs.agilent.com>; from hiren_mehta@agilent.com on Tue, Feb 20, 2001 at 12:50:54PM -0700
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2001 at 12:50:54PM -0700, hiren_mehta@agilent.com wrote:
> barrier() is defined in kernel.h as follows :
> 
> #define barrier() __asm__ __volatile__("": : :"memory")
> 
> what does this mean ? is this like "nop" ?

It's a write barrier. It prevents the compiler from optimising writes
to memory: all outstanding writes should be done before the program
flow crosses the barrier().


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
