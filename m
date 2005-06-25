Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261158AbVFYLIP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261158AbVFYLIP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 07:08:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261174AbVFYLIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 07:08:15 -0400
Received: from bay103-dav12.bay103.hotmail.com ([65.54.174.84]:7305 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S261158AbVFYLHh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 07:07:37 -0400
Message-ID: <BAY103-DAV122C36688460CFE3BDB1A7B2EC0@phx.gbl>
X-Originating-IP: [65.54.174.201]
X-Originating-Email: [pupilla@hotmail.com]
From: "Marco Berizzi" <pupilla@hotmail.com>
To: <linux-kernel@vger.kernel.org>
Subject: 26sec using IPcomp
Date: Sat, 25 Jun 2005 13:06:53 +0200
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1123
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1123
X-OriginalArrivalTime: 25 Jun 2005 11:07:36.0720 (UTC) FILETIME=[18172900:01C57976]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.
I have setup two Openswan 2.3.1 boxes with
linux 2.6.12 (Slackware 10.1).
I have established an ESP/IPcomp tunnel. Tunnel
is correctly established, but there is no packet
flow when these are bigger than 295 bytes.

(Same behaviour with ipsec-tools 0.5.2 When I
disable IPcomp, packet flow is fine.)

Is there any know problem with IPcomp on
Linux 2.6.12 ?

What should I do to debug this problem?

Any feed back are welcome.

PS: Please CC me, I am not subscribed to the list.

This is the setket -D output:

sadb_msg{ version=2 type=18 errno=0 satype=0
  len=2 reserved=0 seq=0 pid=6052

sadb_msg{ version=2 type=18 errno=0 satype=0
  len=30 reserved=1 seq=6 pid=6052
sadb_ext{ len=3 type=5 }
sadb_address{ proto=255 prefixlen=24 reserved=0x0000 }
sockaddr{ len=16 family=2 port=0
 0a010100  }
sadb_ext{ len=3 type=6 }
sadb_address{ proto=255 prefixlen=24 reserved=0x0000 }
sockaddr{ len=16 family=2 port=0
 0a010200  }
sadb_ext{ len=4 type=3 }
sadb_lifetime{ alloc=0, bytes=0
  addtime=0, usetime=0 }
sadb_ext{ len=4 type=4 }
sadb_lifetime{ alloc=0, bytes=0
  addtime=0, usetime=0 }
sadb_ext{ len=4 type=2 }
sadb_lifetime{ alloc=0, bytes=0
  addtime=1119518684, usetime=1119520559 }
sadb_ext{ len=10 type=18 }
sadb_x_policy{ type=2 dir=1 id=68 priority=2344 }
 { len=48 proto=108 mode=2 level=1 reqid=16386
sockaddr{ len=16 family=2 port=0
 ac1001e2  }
sockaddr{ len=16 family=2 port=0
 ac1001f7  }
 }
 { len=16 proto=50 mode=1 level=3 reqid=16385
 }

10.1.1.0/24[any] 10.1.2.0/24[any] any
 in prio high + 1073739480 ipsec
 ipcomp/tunnel/172.16.1.226-172.16.1.247/use#16386
 esp/transport//unique#16385
 created: Jun 23 11:24:44 2005  lastused: Jun 23 11:55:59 2005
 lifetime: 0(s) validtime: 0(s)
 spid=104 seq=6 pid=6052
 refcnt=1
sadb_msg{ version=0 type=0 errno=0 satype=0
  len=0 reserved=0 seq=0 pid=0

sadb_msg{ version=2 type=18 errno=0 satype=0
  len=30 reserved=1 seq=5 pid=6052
sadb_ext{ len=3 type=5 }
sadb_address{ proto=255 prefixlen=24 reserved=0x0000 }
sockaddr{ len=16 family=2 port=0
 0a010200  }
sadb_ext{ len=3 type=6 }
sadb_address{ proto=255 prefixlen=24 reserved=0x0000 }
sockaddr{ len=16 family=2 port=0
 0a010100  }
sadb_ext{ len=4 type=3 }
sadb_lifetime{ alloc=0, bytes=0
  addtime=0, usetime=0 }
sadb_ext{ len=4 type=4 }
sadb_lifetime{ alloc=0, bytes=0
  addtime=0, usetime=0 }
sadb_ext{ len=4 type=2 }
sadb_lifetime{ alloc=0, bytes=0
  addtime=1119520424, usetime=1119520559 }
sadb_ext{ len=10 type=18 }
sadb_x_policy{ type=2 dir=2 id=61 priority=2344 }
 { len=48 proto=108 mode=2 level=1 reqid=16386
sockaddr{ len=16 family=2 port=0
 ac1001f7  }
sockaddr{ len=16 family=2 port=0
 ac1001e2  }
 }
 { len=16 proto=50 mode=1 level=3 reqid=16385
 }

10.1.2.0/24[any] 10.1.1.0/24[any] any
 out prio high + 1073739480 ipsec
 ipcomp/tunnel/172.16.1.247-172.16.1.226/use#16386
 esp/transport//unique#16385
 created: Jun 23 11:53:44 2005  lastused: Jun 23 11:55:59 2005
 lifetime: 0(s) validtime: 0(s)
 spid=97 seq=5 pid=6052
 refcnt=1
sadb_msg{ version=0 type=0 errno=0 satype=0
  len=0 reserved=0 seq=0 pid=0

sadb_msg{ version=2 type=18 errno=0 satype=0
  len=30 reserved=1 seq=4 pid=6052
sadb_ext{ len=3 type=5 }
sadb_address{ proto=255 prefixlen=24 reserved=0x0000 }
sockaddr{ len=16 family=2 port=0
 0a010100  }
sadb_ext{ len=3 type=6 }
sadb_address{ proto=255 prefixlen=24 reserved=0x0000 }
sockaddr{ len=16 family=2 port=0
 0a010200  }
sadb_ext{ len=4 type=3 }
sadb_lifetime{ alloc=0, bytes=0
  addtime=0, usetime=0 }
sadb_ext{ len=4 type=4 }
sadb_lifetime{ alloc=0, bytes=0
  addtime=0, usetime=0 }
sadb_ext{ len=4 type=2 }
sadb_lifetime{ alloc=0, bytes=0
  addtime=1119518684, usetime=0 }
sadb_ext{ len=10 type=18 }
sadb_x_policy{ type=2 dir=3 id=72 priority=2344 }
 { len=48 proto=108 mode=2 level=1 reqid=16386
sockaddr{ len=16 family=2 port=0
 ac1001e2  }
sockaddr{ len=16 family=2 port=0
 ac1001f7  }
 }
 { len=16 proto=50 mode=1 level=3 reqid=16385
 }

10.1.1.0/24[any] 10.1.2.0/24[any] any
 fwd prio high + 1073739480 ipsec
 ipcomp/tunnel/172.16.1.226-172.16.1.247/use#16386
 esp/transport//unique#16385
 created: Jun 23 11:24:44 2005  lastused:
 lifetime: 0(s) validtime: 0(s)
 spid=114 seq=4 pid=6052
 refcnt=1
sadb_msg{ version=0 type=0 errno=0 satype=0
  len=0 reserved=0 seq=0 pid=0

sadb_msg{ version=2 type=18 errno=0 satype=0
  len=22 reserved=1 seq=3 pid=6052
sadb_ext{ len=3 type=5 }
sadb_address{ proto=255 prefixlen=0 reserved=0x0000 }
sockaddr{ len=16 family=2 port=0
 00000000  }
sadb_ext{ len=3 type=6 }
sadb_address{ proto=255 prefixlen=0 reserved=0x0000 }
sockaddr{ len=16 family=2 port=0
 00000000  }
sadb_ext{ len=4 type=3 }
sadb_lifetime{ alloc=0, bytes=0
  addtime=0, usetime=0 }
sadb_ext{ len=4 type=4 }
sadb_lifetime{ alloc=0, bytes=0
  addtime=0, usetime=0 }
sadb_ext{ len=4 type=2 }
sadb_lifetime{ alloc=0, bytes=0
  addtime=1119518684, usetime=0 }
sadb_ext{ len=2 type=18 }
sadb_x_policy{ type=1 dir=1 id=53 priority=0 }

(per-socket policy)
 in none
 created: Jun 23 11:24:44 2005  lastused:
 lifetime: 0(s) validtime: 0(s)
 spid=83 seq=3 pid=6052
 refcnt=1
sadb_msg{ version=48 type=0 errno=108 satype=0
  len=258 reserved=0 seq=16386 pid=0
sadb_ext{ len=2 type=0 }
kdebug_sadb: invalid ext_type 0 was passed.

sadb_msg{ version=2 type=18 errno=0 satype=0
  len=22 reserved=1 seq=2 pid=6052
sadb_ext{ len=3 type=5 }
sadb_address{ proto=255 prefixlen=0 reserved=0x0000 }
sockaddr{ len=16 family=2 port=0
 00000000  }
sadb_ext{ len=3 type=6 }
sadb_address{ proto=255 prefixlen=0 reserved=0x0000 }
sockaddr{ len=16 family=2 port=0
 00000000  }
sadb_ext{ len=4 type=3 }
sadb_lifetime{ alloc=0, bytes=0
  addtime=0, usetime=0 }
sadb_ext{ len=4 type=4 }
sadb_lifetime{ alloc=0, bytes=0
  addtime=0, usetime=0 }
sadb_ext{ len=4 type=2 }
sadb_lifetime{ alloc=0, bytes=0
  addtime=1119518684, usetime=1119520424 }
sadb_ext{ len=2 type=18 }
sadb_x_policy{ type=1 dir=1 id=43 priority=0 }

(per-socket policy)
 in none
 created: Jun 23 11:24:44 2005  lastused: Jun 23 11:53:44 2005
 lifetime: 0(s) validtime: 0(s)
 spid=67 seq=2 pid=6052
 refcnt=1
sadb_msg{ version=48 type=0 errno=108 satype=0
  len=258 reserved=0 seq=16386 pid=0
sadb_ext{ len=2 type=0 }
kdebug_sadb: invalid ext_type 0 was passed.

sadb_msg{ version=2 type=18 errno=0 satype=0
  len=22 reserved=1 seq=1 pid=6052
sadb_ext{ len=3 type=5 }
sadb_address{ proto=255 prefixlen=0 reserved=0x0000 }
sockaddr{ len=16 family=2 port=0
 00000000  }
sadb_ext{ len=3 type=6 }
sadb_address{ proto=255 prefixlen=0 reserved=0x0000 }
sockaddr{ len=16 family=2 port=0
 00000000  }
sadb_ext{ len=4 type=3 }
sadb_lifetime{ alloc=0, bytes=0
  addtime=0, usetime=0 }
sadb_ext{ len=4 type=4 }
sadb_lifetime{ alloc=0, bytes=0
  addtime=0, usetime=0 }
sadb_ext{ len=4 type=2 }
sadb_lifetime{ alloc=0, bytes=0
  addtime=1119518684, usetime=0 }
sadb_ext{ len=2 type=18 }
sadb_x_policy{ type=1 dir=2 id=5c priority=0 }

(per-socket policy)
 out none
 created: Jun 23 11:24:44 2005  lastused:
 lifetime: 0(s) validtime: 0(s)
 spid=92 seq=1 pid=6052
 refcnt=1
sadb_msg{ version=48 type=0 errno=108 satype=0
  len=258 reserved=0 seq=16386 pid=0
sadb_ext{ len=2 type=0 }
kdebug_sadb: invalid ext_type 0 was passed.

sadb_msg{ version=2 type=18 errno=0 satype=0
  len=22 reserved=1 seq=0 pid=6052
sadb_ext{ len=3 type=5 }
sadb_address{ proto=255 prefixlen=0 reserved=0x0000 }
sockaddr{ len=16 family=2 port=0
 00000000  }
sadb_ext{ len=3 type=6 }
sadb_address{ proto=255 prefixlen=0 reserved=0x0000 }
sockaddr{ len=16 family=2 port=0
 00000000  }
sadb_ext{ len=4 type=3 }
sadb_lifetime{ alloc=0, bytes=0
  addtime=0, usetime=0 }
sadb_ext{ len=4 type=4 }
sadb_lifetime{ alloc=0, bytes=0
  addtime=0, usetime=0 }
sadb_ext{ len=4 type=2 }
sadb_lifetime{ alloc=0, bytes=0
  addtime=1119518684, usetime=1119520424 }
sadb_ext{ len=2 type=18 }
sadb_x_policy{ type=1 dir=2 id=4c priority=0 }

(per-socket policy)
 out none
 created: Jun 23 11:24:44 2005  lastused: Jun 23 11:53:44 2005
 lifetime: 0(s) validtime: 0(s)
 spid=76 seq=0 pid=6052
 refcnt=1


