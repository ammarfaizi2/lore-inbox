Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315277AbSFYLwu>; Tue, 25 Jun 2002 07:52:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315388AbSFYLwt>; Tue, 25 Jun 2002 07:52:49 -0400
Received: from flamingo.mail.pas.earthlink.net ([207.217.120.232]:51164 "EHLO
	flamingo.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S315277AbSFYLws>; Tue, 25 Jun 2002 07:52:48 -0400
Date: Tue, 25 Jun 2002 07:54:19 -0400
To: linux-kernel@vger.kernel.org
Subject: nfs livelock on 2.5.24-dj1
Message-ID: <20020625115419.GA12365@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Livelock on 2.5.24-dj1 running bonnie++ over NFS exported with:

root@mountain:/tmp# cat /etc/exports
/opt/testing/nfs 192.168.0.0/24(rw,root_squash,no_wdelay,anonuid=18008,anongid=18008)

Mounted locally (same machine as nfs server) with:
mount -t nfs -o rsize=8192,wsize=8192,hard,intr mountain:/opt/testing/nfs /nfs

stack trace is at:
http://home.earthlink.net/~rwhron/kernel/2.5.24-dj1.nfs.trace.txt

-- 
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html

