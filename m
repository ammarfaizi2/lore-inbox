Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261467AbREQSRr>; Thu, 17 May 2001 14:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261471AbREQSR1>; Thu, 17 May 2001 14:17:27 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:31243 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S261467AbREQSRY>; Thu, 17 May 2001 14:17:24 -0400
Date: Thu, 17 May 2001 20:14:21 +0200
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Anil Kumar <anilk@subexgroup.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: __exit
Message-ID: <20010517201421.L12745@arthur.ubicom.tudelft.nl>
In-Reply-To: <E150IcL-0003v5-00@f4.mail.ru> <NEBBIIKAMMOCGCPMPBJOMEFECCAA.anilk@subexgroup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <NEBBIIKAMMOCGCPMPBJOMEFECCAA.anilk@subexgroup.com>; from anilk@subexgroup.com on Sun, Jun 17, 2001 at 04:02:44PM +0530
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 17, 2001 at 04:02:44PM +0530, Anil Kumar wrote:
> what does __exit, __p and other such directives means in the linux source
> code. what is its significance.

The macros __init and __exit are defined in include/linux/init.h:

#define __init          __attribute__ ((__section__ (".text.init")))
#define __exit          __attribute__ ((unused, __section__(".text.exit")))

And they tell the compiler to put the function in .text.init and
.text.exit sections of the object file.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
