Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751991AbWCOWYc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751991AbWCOWYc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 17:24:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752117AbWCOWYc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 17:24:32 -0500
Received: from zproxy.gmail.com ([64.233.162.193]:53876 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751991AbWCOWYb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 17:24:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=c1YZLfWpeCbuZQr9wQQZre8wHPbP4cCm6nH6h+yL9MCNUa0r8B3et1A25DdVUM+6HbpgkoUojiCLiz/xHRxqr5WNnkFreF28wYcfnc16uy/g/qJVoSJvbIsWwhg482Srgprl7S5lIsLvO61By1QWs37/IEYgy2illFR9UDuuSW8=
Message-ID: <dda83e780603151424u1b3ea605vd6e8dea896fc276e@mail.gmail.com>
Date: Wed, 15 Mar 2006 14:24:30 -0800
From: "Bret Towe" <magnade@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: nfs udp 1000/100baseT issue
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

a while ago i noticed a issue when one has a nfs server that has
gigabit connection
to a network and a client that connects to that network instead via 100baseT
that udp connection from client to server fails the client gets a
server not responding
message when trying to access a file, interesting bit is you can get a directory
listing without issue
work around i found for this is adding proto=tcp to the client side
and all works
without error

ive seen this on kernels as far back as 2.6.13 on my own machines
(was around that time when i accutally got gigabit at home)
and recently noticed on some thin clients i maintain that 2.4 kernels
on the client side are also affected so perhaps its server side issue?
as all servers ive seen this on are 2.6 i havent used 2.4 kernels in ages
on my own machines so i havent looked into if 2.4 has that issue server side
or not

error message i see client side are as follows:
nfs: server vox.net not responding, still trying
nfs: server vox.net not responding, still trying
nfs: server vox.net not responding, still trying

server side shows no errors at all


i was able to cat a couple files and narrow it down to it doesnt like files
over 28504 bytes
kernels at the moment here are client and server 2.6.15.4 but like i
said eariler
version seems to not matter much

any further info needed ask
testing i can also do but it might take me a while before i can get around to it
took me a couple months just to get around to doing this :\
