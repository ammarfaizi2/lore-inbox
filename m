Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263225AbTDRTZZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 15:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263227AbTDRTZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 15:25:25 -0400
Received: from WebDev.iNES.RO ([80.86.100.174]:30336 "EHLO webdev.ines.ro")
	by vger.kernel.org with ESMTP id S263225AbTDRTZY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 15:25:24 -0400
Date: Fri, 18 Apr 2003 22:37:19 +0300 (EEST)
From: Andrei Ivanov <andrei.ivanov@ines.ro>
X-X-Sender: shadow@webdev.ines.ro
To: Andrew Morton <akpm@digeo.com>, "" <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.67-mm4
Message-ID: <Pine.LNX.4.50L0.0304182236480.1931-100000@webdev.ines.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



... and I think there is another problem, but I can't really verify this, 
because I'm not near the machine now, so if somebody else could confirm 
this, it would be great (I hope I'm not getting paranoid :). It seems I 
can't ssh into that machine:

OpenSSH_3.6.1p1, SSH protocols 1.5/2.0, OpenSSL 0x0090609f
debug1: Reading configuration data /etc/ssh/ssh_config
debug1: Rhosts Authentication disabled, originating port will not be 
trusted.
debug1: Connecting to hate.dev.ro [192.168.14.4] port 22.
debug1: Connection established.
debug1: identity file /root/.ssh/identity type -1
debug1: identity file /root/.ssh/id_rsa type -1
debug1: identity file /root/.ssh/id_dsa type -1
debug1: Remote protocol version 1.99, remote software version 
OpenSSH_3.6.1p1
debug1: match: OpenSSH_3.6.1p1 pat OpenSSH*
debug1: Enabling compatibility mode for protocol 2.0
debug1: Local version string SSH-2.0-OpenSSH_3.6.1p1
debug1: SSH2_MSG_KEXINIT sent
debug1: SSH2_MSG_KEXINIT received
debug1: kex: server->client aes128-cbc hmac-md5 none
debug1: kex: client->server aes128-cbc hmac-md5 none
debug1: SSH2_MSG_KEX_DH_GEX_REQUEST sent
debug1: expecting SSH2_MSG_KEX_DH_GEX_GROUP
debug1: SSH2_MSG_KEX_DH_GEX_INIT sent
debug1: expecting SSH2_MSG_KEX_DH_GEX_REPLY
debug1: Host 'hate.dev.ro' is known and matches the RSA host key.
debug1: Found key in /root/.ssh/known_hosts:4
debug1: ssh_rsa_verify: signature correct
debug1: SSH2_MSG_NEWKEYS sent
debug1: expecting SSH2_MSG_NEWKEYS
debug1: SSH2_MSG_NEWKEYS received
debug1: SSH2_MSG_SERVICE_REQUEST sent
debug1: SSH2_MSG_SERVICE_ACCEPT received
debug1: Authentications that can continue: 
publickey,password,keyboard-interactive
debug1: Next authentication method: publickey
debug1: Trying private key: /root/.ssh/identity
debug1: Trying private key: /root/.ssh/id_rsa
debug1: Trying private key: /root/.ssh/id_dsa
debug1: Next authentication method: keyboard-interactive
debug1: Authentications that can continue: 
publickey,password,keyboard-interactive
debug1: Next authentication method: password
root@hate.dev.ro's password:
debug1: Authentication succeeded (password).
debug1: channel 0: new [client-session]
debug1: Entering interactive session.
debug1: channel 0: request pty-req
debug1: channel 0: request shell
debug1: channel 0: open confirm rwindow 0 rmax 32768

Here it hangs... on mm1 I was able to connect with ssh to that machine.
