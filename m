Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271974AbRIJV6T>; Mon, 10 Sep 2001 17:58:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271966AbRIJV6J>; Mon, 10 Sep 2001 17:58:09 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:38159 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S271974AbRIJV55>; Mon, 10 Sep 2001 17:57:57 -0400
Date: Mon, 10 Sep 2001 23:57:25 +0200
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Raghava Raju <vraghava_raju@yahoo.com>
Cc: linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
Subject: Re: Kernel stack....
Message-ID: <20010910235725.C797@arthur.ubicom.tudelft.nl>
In-Reply-To: <20010910214741.19309.qmail@web20008.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010910214741.19309.qmail@web20008.mail.yahoo.com>; from vraghava_raju@yahoo.com on Mon, Sep 10, 2001 at 02:47:41PM -0700
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2001 at 02:47:41PM -0700, Raghava Raju wrote:
>       1) I want to know what exactly is the structure
> of kernel stack. Is it some thing like bss,data,text?
> 
>       2) I want to access kernel stack(in kernel
> mode). So I am using  kernel stack pointer provided in
> thread_struct. So how to access different areas(.i.e 
> data,text)  in kernel stack.

I think you got a wrong understanding of the stack. The stack has no
separate bss, data, and text sections, it's just a stack of function
arguments, local variables, and return addresses.

Accessing the stack works automatically: call a function, and the
function paramaters and the return address are pushed on the stack.
Unless you have a *very* good reason, there is no need to manipulate
the stack directly in kernel mode.


Erik

PS: Please don't cross post between the kernelniewbes and linux-kernel
  lists, use only one of them next time (kernelnewbies is good for this
  kind of questions).

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
