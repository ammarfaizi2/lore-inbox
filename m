Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270109AbTHETVG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 15:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270534AbTHETVG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 15:21:06 -0400
Received: from buttons.universal-fasteners.com ([205.138.133.26]:55056 "HELO
	ykk-ufi.com") by vger.kernel.org with SMTP id S270109AbTHETVB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 15:21:01 -0400
Date: Tue, 5 Aug 2003 15:21:01 -0400
From: Jim Penny <jpenny@universal-fasteners.com>
To: linux-kernel@vger.kernel.org
Subject: ipsec and tunnel mode on kernel 2.6.0-test2
Message-Id: <20030805152101.12d4bfd3.jpenny@universal-fasteners.com>
X-Mailer: Sylpheed version 0.9.3claws (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is it working?

Suppose I am trying to connect 172.18.243.0/24 to 172.18.254.0/24 via
172.18.253.253 and 172.18.254.254. 

I have tried the setkey command:


spdadd 172.18.253.0/24 172.18.254.0/24 any -P in ipsec
        esp/tunnel/172.18.253.253-172.18.254.254/require
        ah/transport//require;


setkey -v -f ...
yieldssadb_msg{ version=2 type=9 errno=0 satype=0
  len=2 reserved=0 seq=0 pid=5474

sadb_msg{ version=2 type=9 errno=0 satype=0
  len=2 reserved=0 seq=0 pid=5474

sadb_msg{ version=2 type=19 errno=0 satype=0
  len=2 reserved=0 seq=0 pid=5474

sadb_msg{ version=2 type=19 errno=0 satype=0
  len=2 reserved=0 seq=0 pid=5474

sadb_msg{ version=2 type=14 errno=0 satype=0
  len=16 reserved=0 seq=0 pid=5474
sadb_ext{ len=8 type=18 }
sadb_x_policy{ type=2 dir=2 id=0 }
 { len=40 proto=50 mode=2 level=1 reqid=0
sockaddr{ len=16 family=2 port=0
 ac12fefe  }
sockaddr{ len=16 family=2 port=0
 ac12fdfd  }
 }
 { len=8 proto=51 mode=1 level=2 reqid=0
 }
sadb_ext{ len=3 type=5 }
sadb_address{ proto=255 prefixlen=24 reserved=0x0000 }
sockaddr{ len=16 family=2 port=0
 ac12fd00  }
sadb_ext{ len=3 type=6 }
sadb_address{ proto=255 prefixlen=24 reserved=0x0000 }
sockaddr{ len=16 family=2 port=0
 ac12fe00  }

sadb_msg{ version=2 type=14 errno=22 satype=0
  len=2 reserved=0 seq=0 pid=5474

The result of line 21: Invalid argument.

--------

Could someone please tell me what I am doing wrong?  

Notes:  direction does not matter, both orders give the same error. 
Ipsec does work if tunnel is replaced by transport.  But I really do
want tunneling!  Presence, or absence of a manual esp with or without -m
tunnel does not appear to matter.  presence or absence of ah line,
presence or absence of manual ah does not appear to matter.

TIA

Jim Penny



