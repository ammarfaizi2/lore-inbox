Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278120AbRJRU0N>; Thu, 18 Oct 2001 16:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278125AbRJRU0D>; Thu, 18 Oct 2001 16:26:03 -0400
Received: from alb-66-24-181-178.nycap.rr.com ([66.24.181.178]:25860 "EHLO
	incandescent.mp3revolution.net") by vger.kernel.org with ESMTP
	id <S278120AbRJRUZu>; Thu, 18 Oct 2001 16:25:50 -0400
Date: Thu, 18 Oct 2001 16:25:40 -0400
From: Andres Salomon <dilinger@mp3revolution.net>
To: alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: Flaws in recent Linux kernels
Message-ID: <20011018162540.B19941@mp3revolution.net>
In-Reply-To: <20011018173540.A6671@emperor.7bulls.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011018173540.A6671@emperor.7bulls.com>
User-Agent: Mutt/1.3.22i
X-Operating-System: Linux incandescent 2.4.10 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When was this fixed in the 2.4 -ac series?  I don't see anything in
notes.249 or notes.2410 about it.  

(see http://lists.insecure.org/bugtraq/2001/Oct/0140.html for
the entire advisory)

On Thu, Oct 18, 2001 at 05:35:40PM +0000, Rafal Wojtczuk wrote:
[...]
> 
> Hello,
> 	There are two bugs present in Linux kernels 2.2.x, x<=19 and 2.4.y, 
> y<=9. The first vulnerability results in local DoS. The second one,
> involving ptrace, can be used to gain root privileges locally (in case of 
> default install of most popular distributions). Linux 2.0.x is not vulnerable 
> to the ptrace bug mentioned.
> 
[...]
> 
> III. Vendor status
> 	The kernel developers were notified on 18th September. 
> vendor-sec at lists dot de was notified on 9th October.
> 
> IV. Availability of patches.
> 	2.4.12 kernel fixes both presented problems. The attached patches,
> 2.2.19-deep-symlink.patch and 2.2.19-ptrace.patch, both blessed by Linus, 
> can be used to close the vulnerability in 2.2.19. The (updated) 
> Openwall GNU/*/Linux kernel patches can be retrieved from
> http://www.openwall.com/linux/
> Note that the default Owl installation is not vulnerable to the ptrace bug
> described.
> 
> V. The exploits
> 	The attached mklink.sh script creates malicious symlinks. 
> 	ptrace-exp.c and insert_shellcode.c exploit the ptrace bug on i386
> architecture. You will probably need to adjust #define in the latter. Note 
> that ptrace-exp uses LD_DEBUG variable to force a setuid program to generate 
> output. This technique (stderr redirected to a pipe, LD_DEBUG set, especially 
> LD_DEBUG=symbols) allows for forced suspending of a setuid binary in a 
> precisely determined moments, which may be helpful to build exploits which 
> rely on race-conditions. And finally, notice that under Owl LD_DEBUG is 
> ignored in case of suid binaries. 
> 
> Save yourself,
> Nergal
> http://www.7bulls.com
> 
> 

-- 
"I think a lot of the basis of the open source movement comes from
  procrastinating students..."
	-- Andrew Tridgell <http://www.linux-mag.com/2001-07/tridgell_04.html>
