Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131894AbRAUBzn>; Sat, 20 Jan 2001 20:55:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131816AbRAUBzf>; Sat, 20 Jan 2001 20:55:35 -0500
Received: from cc361913-a.flrtn1.occa.home.com ([24.0.193.171]:53123 "EHLO
	mirai.cx") by vger.kernel.org with ESMTP id <S131894AbRAUBzV>;
	Sat, 20 Jan 2001 20:55:21 -0500
Message-ID: <3A6A4185.AF34DBA7@pobox.com>
Date: Sat, 20 Jan 2001 17:55:17 -0800
From: J Sloan <jjs@pobox.com>
Organization: Mirai Consulting
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre9-ll i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Aaron Lehmann <aaronl@vitelus.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [OT] Re: 2.4 and ipmasq modules
In-Reply-To: <20010120144616.A16843@vitelus.com>
Content-Type: multipart/alternative;
 boundary="------------BACE5207053D592CD51A2554"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------BACE5207053D592CD51A2554
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Aaron Lehmann wrote:

> It was great to see that 2.4.0 reintroduced ipfwadm support! I had no
> need for ipchains and ended up using the wrapper around it that
> emulated ipfwadm. However, 2.[02].x used to have "special IP
> masquerading modules" such as ip_masq_ftp.o, ip_masq_quake.o, etc. I
> can't find these in 2.4.0. Where have they gone? Without important
> modules such as ip_masq_ftp.o I cannot use non-passive ftp from behind
> the masquerading firewall.

It's working here for me - the netfilter modules are named differently:

# lsmod
Module                 Size  Used by

<snip>

iptable_filter          1824   0 (autoclean) (unused)
ip_nat_ftp              3280   0 (unused)
iptable_nat            13120   1 [ip_nat_ftp]
ip_conntrack_ftp        2016   0 (unused)
ip_conntrack           13408   2 [ip_nat_ftp iptable_nat ip_conntrack_ftp]
ip_tables              10784   4 [iptable_filter iptable_nat]

<snip>




--------------BACE5207053D592CD51A2554
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!doctype html public "-//w3c//dtd html 4.0 transitional//en">
<html>
Aaron Lehmann wrote:
<blockquote TYPE=CITE>It was great to see that 2.4.0 reintroduced ipfwadm
support! I had no
<br>need for ipchains and ended up using the wrapper around it that
<br>emulated ipfwadm. However, 2.[02].x used to have "special IP
<br>masquerading modules" such as ip_masq_ftp.o, ip_masq_quake.o, etc.
I
<br>can't find these in 2.4.0. Where have they gone? Without important
<br>modules such as ip_masq_ftp.o I cannot use non-passive ftp from behind
<br>the masquerading firewall.</blockquote>
It's working here for me - the netfilter modules are named differently:
<p><tt><font size=-1># lsmod</font></tt>
<br><tt><font size=-1>Module&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Size&nbsp; Used by</font></tt><tt><font size=-1></font></tt>
<p><tt><font size=-1>&lt;snip></font></tt><tt><font size=-1></font></tt>
<p><tt><font size=-1>iptable_filter&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
1824&nbsp;&nbsp; 0 (autoclean) (unused)</font></tt>
<br><tt><font size=-1>ip_nat_ftp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
3280&nbsp;&nbsp; 0 (unused)</font></tt>
<br><tt><font size=-1>iptable_nat&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
13120&nbsp;&nbsp; 1 [ip_nat_ftp]</font></tt>
<br><tt><font size=-1>ip_conntrack_ftp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
2016&nbsp;&nbsp; 0 (unused)</font></tt>
<br><tt><font size=-1>ip_conntrack&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
13408&nbsp;&nbsp; 2 [ip_nat_ftp iptable_nat ip_conntrack_ftp]</font></tt>
<br><tt><font size=-1>ip_tables&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
10784&nbsp;&nbsp; 4 [iptable_filter iptable_nat]</font></tt><tt><font size=-1></font></tt>
<p><tt><font size=-1>&lt;snip></font></tt>
<br><tt><font size=-1></font></tt>&nbsp;
<br><tt><font size=-1></font></tt>&nbsp;
<br><tt><font size=-1></font></tt>&nbsp;</html>

--------------BACE5207053D592CD51A2554--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
