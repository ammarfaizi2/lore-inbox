Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314602AbSEPIx4>; Thu, 16 May 2002 04:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316606AbSEPIxz>; Thu, 16 May 2002 04:53:55 -0400
Received: from 217-126-141-228.uc.nombres.ttd.es ([217.126.141.228]:4873 "HELO
	smtp.cespedes.org") by vger.kernel.org with SMTP id <S314602AbSEPIxt>;
	Thu, 16 May 2002 04:53:49 -0400
Date: Thu, 16 May 2002 10:53:55 +0200
From: Juan Cespedes <cespedes@debian.org>
To: "Jason A. Ramsey" <jason@l337hosting.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ip addr add
Message-ID: <20020516085355.GA9952@gizmo.thehackers.org>
In-Reply-To: <FFAF1479E6949F4DAE87D09E1292D0376A62@azog.l337hosting.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2002 at 04:50:15PM -0700, Jason A. Ramsey wrote:
> I'm working with a RH7.3 box that has iproute2 installed. I am trying to
> configure a slew of virtual interfaces on the server to accommodate
> ip-based virtual hosting with Apache. I was led to believe that it was
> possible to provision a group of addresses with a single command that
> would cause the host to listen on all those addresses. I would like to
> configure addresses 172.20.0.128-172.20.0.254 on the box without having
> to manually specify every address. Is this possible? Thanks.

If you don't mind adding also IP 172.20.0.255, so that you can use a
netmask 255.255.255.128, you can use the following:

ip route add local 172.20.0.128/25 dev eth0

(replacing "eth0" with your network interface, of course).

-- 
Juan Cespedes
http://www.cespedes.org/
