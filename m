Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313666AbSDHUCY>; Mon, 8 Apr 2002 16:02:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313676AbSDHUCX>; Mon, 8 Apr 2002 16:02:23 -0400
Received: from generic.whogotit.com ([216.4.73.9]:14861 "HELO clausfischer.com")
	by vger.kernel.org with SMTP id <S313666AbSDHUCX>;
	Mon, 8 Apr 2002 16:02:23 -0400
Date: Mon, 8 Apr 2002 22:02:15 +0200
From: Claus Fischer <claus.fischer@clausfischer.com>
To: linux-kernel@vger.kernel.org
Subject: Spoof protection with redundant routes
Message-ID: <20020408220215.A1987@clausfischer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have a box with two redundant CIPE tunnels to a
remote network 10.36.x.x.


Routing table:

Destination  Gateway      Genmask           ...      Iface
...	     		  		    
10.36.1.12   0.0.0.0      255.255.255.255   UH 0 0 0 cipcb3
10.36.1.11   0.0.0.0      255.255.255.255   UH 0 0 0 cipcb1
10.36.0.0    10.36.1.12   255.255.0.0       UG 0 0 0 cipcb3
10.36.0.0    10.36.1.11   255.255.0.0       UG 0 0 0 cipcb1
...


Now when a packet comes in from 10.36.2.2 on cipcb1, the
spoof protection kills it, since the outgoing packet would
take the route via cipcb3 which is first. I didn't quite
expect that initially.

- Is that known and by design?
- Is that the desired behaviour?
- Is there some possibility to change that?
- Do I have a choice other than to turn off rp_filter?

Claus

-- 
Claus Fischer <claus.fischer@clausfischer.com>
http://www.clausfischer.com/
