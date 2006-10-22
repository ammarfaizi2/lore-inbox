Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751784AbWJVRrx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751784AbWJVRrx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 13:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751786AbWJVRrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 13:47:52 -0400
Received: from moutng.kundenserver.de ([212.227.126.177]:55547 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751784AbWJVRrw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 13:47:52 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Avi Kivity <avi@qumranet.com>
Subject: Re: [PATCH 0/7] KVM: Kernel-based Virtual Machine
Date: Sun, 22 Oct 2006 19:47:21 +0200
User-Agent: KMail/1.9.5
Cc: Muli Ben-Yehuda <muli@il.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Anthony Liguori <aliguori@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <4537818D.4060204@qumranet.com> <200610221906.33085.arnd@arndb.de> <453BAD66.5000406@qumranet.com>
In-Reply-To: <453BAD66.5000406@qumranet.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200610221947.21638.arnd@arndb.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:bf0b512fe2ff06b96d9695102898be39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 22 October 2006 19:41, Avi Kivity wrote:
> One last thing: permissions.  The /dev/kvm model allows permissions to
> be controlled using standard unix access methods.  How do you control
> access to spufs?

The mount point has permissions that you can set to allow read/write
access to users/groups. You can do that as a mount option or later
with chmod.

spu_create has an argument to specify the permissions for a new
object and follows the regular umask rules.

I also chose to allow users to set permissions on each file in order
to do cross-user IPC, but so far, nobody has used this to my knowledge.

	Arnd <><
