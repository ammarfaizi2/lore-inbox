Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289914AbSAKL7k>; Fri, 11 Jan 2002 06:59:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289919AbSAKL7a>; Fri, 11 Jan 2002 06:59:30 -0500
Received: from svr3.applink.net ([206.50.88.3]:58633 "EHLO svr3.applink.net")
	by vger.kernel.org with ESMTP id <S289914AbSAKL7S>;
	Fri, 11 Jan 2002 06:59:18 -0500
Message-Id: <200201111159.g0BBxCSr001144@svr3.applink.net>
Content-Type: text/plain;
  charset="gb2312"
From: Timothy Covell <timothy.covell@ashavan.org>
Reply-To: timothy.covell@ashavan.org
To: timothy.covell@ashavan.org, "Pei Zheng" <zhengpei@msu.edu>,
        <linux-kernel@vger.kernel.org>
Subject: Re: strange kernel message when hacking the NIC driver
Date: Fri, 11 Jan 2002 05:55:20 -0600
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <LIECKFOKGFCHAPOBKPECEEGCCNAA.zhengpei@msu.edu> <200201110524.g0B5OeSr000566@svr3.applink.net>
In-Reply-To: <200201110524.g0B5OeSr000566@svr3.applink.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 January 2002 23:20, Timothy Covell wrote:


Let me clarify what I said earlier.  You cannot have
identical MAC addresses on two different NICs.   Indeed,
it is impossible w/o trying to fool the kernel into
redefining the NICs hardware based MAC address. 

As concerns TCP/IP, you can define two NICs to have the
same IP address, but you will only end up confusing
your switch/HUB router which assumes a 1 to 1 mapping
of MACs to IPs.   The whole point of ICMP is to
discover this mapping via ARP requests.

If you want to increase your aggregate bandwidth, then
there are several methods.  One is to use the bonding 
driver to make the NICs look like one but it needs to 
be supported by the switch that you use or for point-to-point 
connections, the other box. Another way is to use something 
like OSPF or advanced iptable routing to effect multipathing.  
Finally, a crude way to increase your effective bandwidth is 
to run several instances of your server(s) on different IP 
addresses/NICS but they cannot all have default routes on 
Linux without resorting to OSPF and/or iptables.


-- 
timothy.covell@ashavan.org.
