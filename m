Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265489AbUIEBLU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265489AbUIEBLU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 21:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265930AbUIEBLM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 21:11:12 -0400
Received: from main.gmane.org ([80.91.224.249]:59579 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S265847AbUIEBJa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 21:09:30 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?ISO-8859-15?Q?Sven_K=F6hler?= <skoehler@upb.de>
Subject: why do i get "Stale NFS file handle" for hours?
Date: Sun, 05 Sep 2004 03:06:10 +0200
Message-ID: <chdp06$e56$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd9ee3e93.dip.t-dialin.net
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4.2) Gecko/20040426
X-Accept-Language: de, en
Cc: nfs@lists.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

i think i know what's going an, and why i get the "stale nfs handle" 
error-message when the NFS server is restartet (real reboot, or a simply 
/etc/init.d/nfs restart) but what i don't understand is, why the NFS 
client doesn't "remount" the filesystem autmatically. In case of NFS 
over tcp, the NFS client could easily detect a restart of the NFS server 
(the tcp-connection was aborted) or are there other factors that keep 
the NFS client from recognizing such stuff?

The scenaria that made me writing this, is that i'm setting up an NFS 
server at my college right now. It will export a directory to many 
clients where i don't have root-access. The NFS-directories are mounted 
by the clients via automounter, and if i restart my Server for any 
reason, i will get the "stale nfs handle" for hours. The kernel does 
neither remount nor unmount the directory, and the automounter simply 
doesn't unmount it too. It keeps mounted, and that will cause me 
troubles for hours.

Were that any thought on that subject here or in any other mailinglist?
Is there any chance, that this might be improved in the future somehow?


Thx
   Sven


