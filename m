Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261458AbVCFSI4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261458AbVCFSI4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 13:08:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261457AbVCFSI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 13:08:56 -0500
Received: from FW-30-241.go.retevision.es ([62.174.241.30]:58159 "EHLO
	puil.ghetto") by vger.kernel.org with ESMTP id S261449AbVCFSIj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 13:08:39 -0500
Date: Sun, 6 Mar 2005 19:08:33 +0100
To: Alessandro Selli <dhatarattha@route-add.net>
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Vanilla kernel >=2.4.28-rc2 incompatibility with ADSL modem Dlink DSL-G300+
Message-ID: <20050306180833.GA4398@larroy.com>
Mail-Followup-To: Alessandro Selli <dhatarattha@route-add.net>,
	linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
References: <422B3F60.8020303@route-add.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <422B3F60.8020303@route-add.net>
User-Agent: Mutt/1.5.6+20040907i
From: piotr@larroy.com (Pedro Larroy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 06, 2005 at 06:35:28PM +0100, Alessandro Selli wrote:
>  Hello,
> I found a problem having to to with the plain vanilla 2.4.28-rc{2,3} and
> 2.4.29 kernels when I try to use a Dlink DSL-300G+ ethernet ADSL modem
> on a SS5 machine.
> 
> The domain "route-add.net" is running on a Sun SparcStation 5 machine,
> equipped with a Micro-SPARCII, 85 MHz processor. This machine has beeing
> running the domain (web, smtp, ssh, imap, telnet, gopher, finger,
> auth/ident, dns) for a year. The machine has two "le" (10 base T)
> ethernet ports, one is connected to the ADSL modem, the other to the LAN.
> The OS is Debian stable (Woody, 3.0).
> The kernel is a plain vanilla one, downloaded from
> ftp.it.kernel.org/pub/linux/kernel/v2.4 with no patches applied to it.
> 
> The problem showed up after updating to kernel 2.4.28: the ADSL
> connection would never outlive the fifteenth minute.  Even though the
> modem still sensed the ADSL carrier and could be reached into its
> web-based internal control panel over the same ethernet connection that
> served the data exchanged with the ISP, after fifteen minutes it could
> first reach the ISP gateway the connection failed and no packets could
> be neither sent nor received with any host outside the LAN.  The
> connection would be available again after a period varying from a few
> minutes to several hours, three quarters of an hour on the average.
> A script that was let running from Jannuary 18th to February 3rd (data
> from Jannuary 29th was lost) produced the following data:
> 
> http://route-add.net/ping-noping.txt ("riuscito" = success, "fallito" =
> failed)
> http://route-add.net/ping-noping_18012005-28012005.txt
> http://route-add.net/ping-noping_07012005-17012005.txt ("persa" = lost
> [connection], "tornata" = [coonection is] back)
> 
> I tried changing the wiring, I swapped the ethernet ports the LAN and
> ADSL modem where connected to, I swapped the modem with an identical one
> from a colleague of mine, I upgraded to kernel 2.4.29 all to no avail.
>   I then tried the 2.4.28-rc{1,2,3} kernels, and I found the 2.4.28-rc1
> not to exhibit the problem, that manifests itself on the 2.4.28-rc{2,3}
> kernels.
>   The problem is sparc-specific, a PC with the very same configuration
> (Debian stable, plain vanilla kernels etc.) did not suffer any
> connection drops.
> 
> -- 
> Alessandro Selli
> Tel: 340.839.73.05
> http://alessandro.route-add.net
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

I have seen similar problems due to high sequence numbers on the tcp
packets on some adsl routers. Took a while to discover that since the
connection misteriously ceased to work from some boxes after some time
transmitting data ok. Looks like some manufacturers such as efficient
networks adsl routers, doesn't follow the standards.

I'd suggest running tcpdump and doing some observation.

-- 
Pedro Larroy Tovar | Linux & Network consultant |  pedro%larroy.com 
Make debian mirrors with debian-multimirror: http://pedro.larroy.com/deb_mm/
	* Las patentes de programación son nocivas para la innovación * 
				http://proinnova.hispalinux.es/
