Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262848AbTIQVav (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 17:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262850AbTIQVau
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 17:30:50 -0400
Received: from smtp-int-01.mx.pitdc1.stargate.net ([206.210.69.149]:9917 "EHLO
	smtp-int-01.mx.pitdc1.stargate.net") by vger.kernel.org with ESMTP
	id S262848AbTIQVat (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 17:30:49 -0400
Message-ID: <3F68D055.3090701@psc.edu>
Date: Wed, 17 Sep 2003 17:21:25 -0400
From: Paul N <pauln@psc.edu>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.20 NFS / EJUKEBOX problem
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I'm seeing a weird problem with NFSv3's EJUKEBOX when
mounting a irix machine running DMF (software for managing offline/tape
copies of files).    When an NFS read request is made for an 'offline' file
it causes other write requests to stall until the 'offline'  file is 
unmigrated to
disk and the read can resume. 
 From looking at tcpdump it seems that the write requests proceed until
an EJUKEBOX msg from the read is returned from the server.  At that point
all write requests are stuck behind the  jukeboxed read. 

Could someone please give me some information on this?

Thanks
Paul


