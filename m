Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293402AbSCUHR3>; Thu, 21 Mar 2002 02:17:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293465AbSCUHRS>; Thu, 21 Mar 2002 02:17:18 -0500
Received: from poplar.cs.washington.edu ([128.95.2.24]:54534 "EHLO
	poplar.cs.washington.edu") by vger.kernel.org with ESMTP
	id <S293503AbSCUHRO>; Thu, 21 Mar 2002 02:17:14 -0500
Date: Wed, 20 Mar 2002 23:17:08 -0800
From: Neil Spring <nspring@cs.washington.edu>
To: yasu@ysuzuki.net
Cc: linux-kernel@vger.kernel.org, ysuzuki@bb.mbn.or.jp
Subject: Re: PROBLEM: TCP CWR and ECE flags
Message-ID: <20020321071658.GA13805@cs.washington.edu>
In-Reply-To: <20020321024403.GB1190%ysuzuki@bb.mbn.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2002 at 11:44:03AM +0900, SUZUKI Yasuhiro wrote:
> A web page
>   http://www.icir.org/floyd/papers/ECN.Oct2000.txt
> says that 
>   * If Host A does not get any reply to its initial SYN (which had CWR
>     and ECE set) within the normal SYN retransmission timeout interval,
>     then Host A resends the SYN and any subsequent SYN retransmissions
>     with CWR and ECE cleared.
>   where Host A is a client and Host B is a server.

It also says:

  This note outlines a procedure that ECN-Capable TCP implementations
  may wish to use in this case to ensure connectivity.  We are not
  suggesting that TCP implementations should be required to use this
  procedure.

If you don't like linux's behavior,
su
echo 0 > /proc/sys/net/ipv4/tcp_ecn
echo "net/ipv4/tcp_ecn=0" >> /etc/sysctl.conf

If you don't like nifty.com's ECN violating behavior,
send them mail.

See the faq, as mentioned at the footer of all
Linux-kernel mailing lists, and specifically at
http://www.tux.org/lkml/#s14-2 for additional information.

-neil

