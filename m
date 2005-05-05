Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262088AbVEEPlF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262088AbVEEPlF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 11:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262135AbVEEPlE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 11:41:04 -0400
Received: from bay10-f36.bay10.hotmail.com ([64.4.37.36]:50053 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S262088AbVEEPkY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 11:40:24 -0400
Message-ID: <BAY10-F3687DB92C3312BF50504CBD61A0@phx.gbl>
X-Originating-IP: [61.246.101.228]
X-Originating-Email: [agovinda04@hotmail.com]
From: "govind raj" <agovinda04@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: ssh and serial console problem
Date: Thu, 05 May 2005 21:08:22 +0530
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 05 May 2005 15:38:22.0772 (UTC) FILETIME=[786CB740:01C55188]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,


I have a customized Linux which supports a serial console interface.

I am able to successfully ssh into this Linux system. If I try to use any of 
the secure (ssh, scp) programs from this ssh session, I am able to 
successfully use them. If I try the same program from the serial console, I 
get a "Login failed: Permission denied" message.

Since the same userid is able to login from/to this system from a ssh 
session into this box, I presume that this eliminates any user-specific or 
ssh-configuration-specific problems/issues?

Are there any known limitations in running the ssh/scp programs on the 
/dev/console interface? It does not allow me to enter the password on this 
session and then quickly scrolls out to the attempt till it fails in the 3rd 
attempt and reports the failure?

Here is the relevant output:

bash-2.05a# ssh -v 192.168.0.24
OpenSSH_3.9p1, OpenSSL 0.9.7a Feb 19 2003
debug1: Reading configuration data /etc/ssh/ssh_config
debug1: Connecting to 192.168.0.24 [192.168.0.24] port 22.
debug1: Connection established.
debug1: permanently_set_uid: 0/0
debug1: identity file /root/.ssh/identity type -1
debug1: identity file /root/.ssh/id_rsa type -1
debug1: identity file /root/.ssh/id_dsa type -1
debug1: Remote protocol version 1.99, remote software version OpenSSH_3.9p1
debug1: match: OpenSSH_3.9p1 pat OpenSSH*
debug1: Enabling compatibility mode for protocol 2.0
debug1: Local version string SSH-2.0-OpenSSH_3.9p1
debug1: SSH2_MSG_KEXINIT sent
debug1: SSH2_MSG_KEXINIT received
debug1: kex: server->client aes128-cbc hmac-md5 none
debug1: kex: client->server aes128-cbc hmac-md5 none
debug1: SSH2_MSG_KEX_DH_GEX_REQUEST(1024<1024<8192) sent
debug1: expecting SSH2_MSG_KEX_DH_GEX_GROUP
debug1: SSH2_MSG_KEX_DH_GEX_INIT sent
debug1: expecting SSH2_MSG_KEX_DH_GEX_REPLY
debug1: Host '192.168.0.24' is known and matches the RSA host key.
debug1: Found key in /root/.ssh/known_hosts:1
debug1: ssh_rsa_verify: signature correct
debug1: SSH2_MSG_NEWKEYS sent
debug1: expecting SSH2_MSG_NEWKEYS
debug1: SSH2_MSG_NEWKEYS received
debug1: SSH2_MSG_SERVICE_REQUEST sent
debug1: SSH2_MSG_SERVICE_ACCEPT received
debug1: Authentications that can continue: 
publickey,gssapi-with-mic,password,ke
debug1: Next authentication method: publickey
debug1: Trying private key: /root/.ssh/identity
debug1: Trying private key: /root/.ssh/id_rsa
debug1: Trying private key: /root/.ssh/id_dsa
debug1: Next authentication method: keyboard-interactive
debug1: Authentications that can continue: 
publickey,gssapi-with-mic,password,ke
debug1: Next authentication method: password
debug1: Authentications that can continue: 
publickey,gssapi-with-mic,password,ke
Permission denied, please try again.
debug1: Authentications that can continue: 
publickey,gssapi-with-mic,password,ke
Permission denied, please try again.
debug1: Authentications that can continue: 
publickey,gssapi-with-mic,password,ke
debug1: No more authentication methods to try.
Permission denied (publickey,gssapi-with-mic,password,keyboard-interactive).
bash-2.05a#

Thanks in advance for your help and time,

Govind
http://www.sahasrasolutions.com

_________________________________________________________________
Mother's Day is Here! 
http://adfarm.mediaplex.com/ad/ck/4686-26272-10936-264?ck=Sell Find a 
present for your Mom right here on eBay!

