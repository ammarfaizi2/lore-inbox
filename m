Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271832AbTGRPge (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 11:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267576AbTGRPai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 11:30:38 -0400
Received: from imap.gmx.net ([213.165.64.20]:58547 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S271867AbTGRP0y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 11:26:54 -0400
Message-Id: <5.2.1.1.2.20030718174433.01b12878@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Fri, 18 Jul 2003 17:46:01 +0200
To: Wiktor Wodecki <wodecki@gmx.net>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH] O6int for interactivity
Cc: Nick Piggin <piggin@cyberone.com.au>,
       Davide Libenzi <davidel@xmailserver.org>,
       Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>
In-Reply-To: <20030718103105.GE622@gmx.de>
References: <5.2.1.1.2.20030718120229.01a8fcf0@pop.gmx.net>
 <5.2.1.1.2.20030718071656.01af84d0@pop.gmx.net>
 <200307170030.25934.kernel@kolivas.org>
 <200307170030.25934.kernel@kolivas.org>
 <5.2.1.1.2.20030718071656.01af84d0@pop.gmx.net>
 <5.2.1.1.2.20030718120229.01a8fcf0@pop.gmx.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="=====================_17588671==_"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=====================_17588671==_
Content-Type: text/plain; charset="us-ascii"; format=flowed

At 12:31 PM 7/18/2003 +0200, Wiktor Wodecki wrote:
>On Fri, Jul 18, 2003 at 12:18:33PM +0200, Mike Galbraith wrote:
> > That _might_ (add salt) be priorities of kernel threads dropping too low.
> >
> > I'm also seeing occasional total stalls under heavy I/O in the order of
> > 10-12 seconds (even the disk stops).  I have no idea if that's 
> something in
> > mm or the scheduler changes though, as I've yet to do any isolation and/or
> > tinkering.  All I know at this point is that I haven't seen it in stock 
> yet.
>
>I've seen this too while doing a huge nfs transfer from a 2.6 machine to
>a 2.4 machine (sparc32). Thought it'd be something with the nfs changes
>which were recently, might be the scheduler, tho. Ah, and it is fully
>reproducable.

Telling to not mess with my kernel threads seems to have fixed it here... 
no stalls during the whole contest run.  New contest numbers attached.

         -Mike 
--=====================_17588671==_
Content-Type: text/plain; name="contest.txt";
 x-mac-type="42494E41"; x-mac-creator="74747874"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="contest.txt"

bm9fbG9hZDoKS2VybmVsICAgICAgICAgICBbcnVuc10JVGltZQlDUFUlCUxvYWRzCUxDUFUlCVJh
dGlvCjIuNS42OSAgICAgICAgICAgICAgICAxCTE1Mwk5NC44CTAuMAkwLjAJMS4wMAoyLjUuNzAg
ICAgICAgICAgICAgICAgMQkxNTMJOTQuMQkwLjAJMC4wCTEuMDAKMi42LjAtdGVzdDEgICAgICAg
ICAgIDEJMTUzCTk0LjEJMC4wCTAuMAkxLjAwCjIuNi4wLXRlc3QxLW1tMSAgICAgICAxCTE1Mgk5
NC43CTAuMAkwLjAJMS4wMAoyLjYuMC10ZXN0MS1tbTFYICAgICAgMQkxNTMJOTQuOAkwLjAJMC4w
CTEuMDAKY2FjaGVydW46Cktlcm5lbCAgICAgICAgICAgW3J1bnNdCVRpbWUJQ1BVJQlMb2FkcwlM
Q1BVJQlSYXRpbwoyLjUuNjkgICAgICAgICAgICAgICAgMQkxNDYJOTguNgkwLjAJMC4wCTAuOTUK
Mi41LjcwICAgICAgICAgICAgICAgIDEJMTQ2CTk4LjYJMC4wCTAuMAkwLjk1CjIuNi4wLXRlc3Qx
ICAgICAgICAgICAxCTE0Ngk5OC42CTAuMAkwLjAJMC45NQoyLjYuMC10ZXN0MS1tbTEgICAgICAg
MQkxNDYJOTguNgkwLjAJMC4wCTAuOTYKMi42LjAtdGVzdDEtbW0xWCAgICAgIDEJMTQ2CTk4LjYJ
MC4wCTAuMAkwLjk1CnByb2Nlc3NfbG9hZDoKS2VybmVsICAgICAgICAgICBbcnVuc10JVGltZQlD
UFUlCUxvYWRzCUxDUFUlCVJhdGlvCjIuNS42OSAgICAgICAgICAgICAgICAxCTMzMQk0My44CTkw
LjAJNTUuMwkyLjE2CjIuNS43MCAgICAgICAgICAgICAgICAxCTE5OQk3Mi40CTI3LjAJMjUuNQkx
LjMwCjIuNi4wLXRlc3QxICAgICAgICAgICAxCTI2NAk1NC41CTYxLjAJNDQuMwkxLjczCjIuNi4w
LXRlc3QxLW1tMSAgICAgICAxCTMyMwk0NC45CTg4LjAJNTQuMgkyLjEyCjIuNi4wLXRlc3QxLW1t
MVggICAgICAxCTI2OAk1NC4xCTYyLjAJNDQuOAkxLjc1CmN0YXJfbG9hZDoKS2VybmVsICAgICAg
ICAgICBbcnVuc10JVGltZQlDUFUlCUxvYWRzCUxDUFUlCVJhdGlvCjIuNS42OSAgICAgICAgICAg
ICAgICAxCTE5MAk3Ny45CTAuMAkwLjAJMS4yNAoyLjUuNzAgICAgICAgICAgICAgICAgMQkxODYJ
ODAuMQkwLjAJMC4wCTEuMjIKMi42LjAtdGVzdDEgICAgICAgICAgIDEJMjEzCTcwLjQJMC4wCTAu
MAkxLjM5CjIuNi4wLXRlc3QxLW1tMSAgICAgICAxCTIwNwk3Mi41CTAuMAkwLjAJMS4zNgoyLjYu
MC10ZXN0MS1tbTFYICAgICAgMQkyMTMJNzAuNAkwLjAJMC4wCTEuMzkKeHRhcl9sb2FkOgpLZXJu
ZWwgICAgICAgICAgIFtydW5zXQlUaW1lCUNQVSUJTG9hZHMJTENQVSUJUmF0aW8KMi41LjY5ICAg
ICAgICAgICAgICAgIDEJMTk2CTc1LjAJMC4wCTMuMQkxLjI4CjIuNS43MCAgICAgICAgICAgICAg
ICAxCTE5NQk3NS45CTAuMAkzLjEJMS4yNwoyLjYuMC10ZXN0MSAgICAgICAgICAgMQkxOTMJNzYu
NwkxLjAJNC4xCTEuMjYKMi42LjAtdGVzdDEtbW0xICAgICAgIDEJMTk1CTc1LjkJMS4wCTQuMQkx
LjI4CjIuNi4wLXRlc3QxLW1tMVggICAgICAxCTE5MQk3Ny41CTEuMAk0LjIJMS4yNQppb19sb2Fk
OgpLZXJuZWwgICAgICAgICAgIFtydW5zXQlUaW1lCUNQVSUJTG9hZHMJTENQVSUJUmF0aW8KMi41
LjY5ICAgICAgICAgICAgICAgIDEJNDM3CTM0LjYJNjkuMQkxNS4xCTIuODYKMi41LjcwICAgICAg
ICAgICAgICAgIDEJNDAxCTM3LjcJNzIuMwkxNy40CTIuNjIKMi42LjAtdGVzdDEgICAgICAgICAg
IDEJMjQzCTYxLjMJNDguMQkxNy4zCTEuNTkKMi42LjAtdGVzdDEtbW0xICAgICAgIDEJMzM2CTQ0
LjkJNjQuNQkxNy4zCTIuMjEKMi42LjAtdGVzdDEtbW0xWCAgICAgIDEJMzE3CTQ3LjMJNjMuNQkx
Ny43CTIuMDcKaW9fb3RoZXI6Cktlcm5lbCAgICAgICAgICAgW3J1bnNdCVRpbWUJQ1BVJQlMb2Fk
cwlMQ1BVJQlSYXRpbwoyLjUuNjkgICAgICAgICAgICAgICAgMQkzODcJMzguOAk2OS4zCTE3LjMJ
Mi41MwoyLjUuNzAgICAgICAgICAgICAgICAgMQk0MjIJMzYuMAk3NS4zCTE3LjEJMi43NgoyLjYu
MC10ZXN0MSAgICAgICAgICAgMQkyNTgJNTcuOAk1NS44CTE5LjAJMS42OQoyLjYuMC10ZXN0MS1t
bTEgICAgICAgMQkzMzAJNDUuNQk2My4yCTE3LjIJMi4xNwoyLjYuMC10ZXN0MS1tbTFYICAgICAg
MQkzMDIJNDkuNwk1OS4xCTE3LjIJMS45NwpyZWFkX2xvYWQ6Cktlcm5lbCAgICAgICAgICAgW3J1
bnNdCVRpbWUJQ1BVJQlMb2FkcwlMQ1BVJQlSYXRpbwoyLjUuNjkgICAgICAgICAgICAgICAgMQky
MjEJNjcuMAk5LjQJMy42CTEuNDQKMi41LjcwICAgICAgICAgICAgICAgIDEJMjIwCTY3LjMJOS40
CTMuNgkxLjQ0CjIuNi4wLXRlc3QxICAgICAgICAgICAxCTIwMAk3NC4wCTkuNwk0LjAJMS4zMQoy
LjYuMC10ZXN0MS1tbTEgICAgICAgMQkxOTAJNzguNAk5LjIJNC4yCTEuMjUKMi42LjAtdGVzdDEt
bW0xWCAgICAgIDEJMTg3CTc5LjcJOC40CTMuNwkxLjIyCmxpc3RfbG9hZDoKS2VybmVsICAgICAg
ICAgICBbcnVuc10JVGltZQlDUFUlCUxvYWRzCUxDUFUlCVJhdGlvCjIuNS42OSAgICAgICAgICAg
ICAgICAxCTIwMwk3MS40CTk5LjAJMjAuMgkxLjMzCjIuNS43MCAgICAgICAgICAgICAgICAxCTIw
NQk3MC43CTEwNC4wCTIwLjUJMS4zNAoyLjYuMC10ZXN0MSAgICAgICAgICAgMQkxOTkJNzIuNAkx
MDIuMAkyMS42CTEuMzAKMi42LjAtdGVzdDEtbW0xICAgICAgIDEJMTkzCTc1LjEJOTEuMAkxOS43
CTEuMjcKMi42LjAtdGVzdDEtbW0xWCAgICAgIDEJMTk0CTc0LjcJOTEuMAkxOS42CTEuMjcKbWVt
X2xvYWQ6Cktlcm5lbCAgICAgICAgICAgW3J1bnNdCVRpbWUJQ1BVJQlMb2FkcwlMQ1BVJQlSYXRp
bwoyLjUuNjkgICAgICAgICAgICAgICAgMQkyNTYJNTcuOAkzNC4wCTEuMgkxLjY3CjIuNS43MCAg
ICAgICAgICAgICAgICAxCTI1Mgk1OC43CTMzLjAJMS4yCTEuNjUKMi42LjAtdGVzdDEgICAgICAg
ICAgIDEJMzA5CTQ4LjIJNzUuMAkyLjMJMi4wMgoyLjYuMC10ZXN0MS1tbTEgICAgICAgMQkyNzcJ
NTMuOAkzOC4wCTEuNAkxLjgyCjIuNi4wLXRlc3QxLW1tMVggICAgICAxCTIyNQk2NS44CTM4LjAJ
MS44CTEuNDcKZGJlbmNoX2xvYWQ6Cktlcm5lbCAgICAgICAgICAgW3J1bnNdCVRpbWUJQ1BVJQlM
b2FkcwlMQ1BVJQlSYXRpbwoyLjUuNjkgICAgICAgICAgICAgICAgMQk1MTcJMjguOAk1LjAJMzUu
NgkzLjM4CjIuNS43MCAgICAgICAgICAgICAgICAxCTQyNAkzNS4xCTMuMAkyNi43CTIuNzcKMi42
LjAtdGVzdDEgICAgICAgICAgIDEJMzQ3CTQyLjcJNC4wCTM5LjUJMi4yNwoyLjYuMC10ZXN0MS1t
bTEgICAgICAgMQkzNzcJMzkuOAk0LjAJMzYuOQkyLjQ4CjIuNi4wLXRlc3QxLW1tMVggICAgICAx
CTUxMAkyOS40CTUuMAkzNC4zCTMuMzMKYWJfbG9hZDoKS2VybmVsICAgICAgICAgICBbcnVuc10J
VGltZQlDUFUlCUxvYWRzCUxDUFUlCVJhdGlvCjIuNS42OSAgICAgICAgICAgICAgICAxCTMwMAk0
OC4zCTQ2LjAJMjEuNwkxLjk2CjIuNS43MCAgICAgICAgICAgICAgICAxCTMwMAk0OC4wCTQ2LjAJ
MjIuMAkxLjk2CjIuNi4wLXRlc3QxICAgICAgICAgICAxCTI4MQk1MS42CTUwLjAJMjUuNgkxLjg0
CjIuNi4wLXRlc3QxLW1tMSAgICAgICAxCTIyOQk2My4zCTMwLjAJMTguMwkxLjUxCjIuNi4wLXRl
c3QxLW1tMVggICAgICAxCTIyNQk2NC40CTI3LjAJMTguMgkxLjQ3CmlybWFuMl9sb2FkOgpLZXJu
ZWwgICAgICAgICAgIFtydW5zXQlUaW1lCUNQVSUJTG9hZHMJTENQVSUJUmF0aW8KMi42LjAtdGVz
dDEgICAgICAgICAgIDEJOTk5CTE0LjUJMzEuMAkwLjAJNi41MwoyLjYuMC10ZXN0MS1tbTEgICAg
ICAgMQkyMTAJNjkuMAk2LjAJMC4wCTEuMzgKMi42LjAtdGVzdDEtbW0xWCAgICAgIDEJMjEwCTY5
LjAJNi4wCTAuMAkxLjM3Cg==
--=====================_17588671==_--

