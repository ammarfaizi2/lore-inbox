Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129210AbQLTIB0>; Wed, 20 Dec 2000 03:01:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129431AbQLTIBQ>; Wed, 20 Dec 2000 03:01:16 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:34961 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S129210AbQLTIBK>; Wed, 20 Dec 2000 03:01:10 -0500
From: Christoph Rohland <cr@sap.com>
To: buhr@stat.wisc.edu (Kevin Buhr)
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test5 bug: invalid "shmid_kernel" passed to "shm_nopage_core"
In-Reply-To: <vbaaeapf4ti.fsf@mozart.stat.wisc.edu>
	<m3g0kggydi.fsf@linux.local> <vbay9y7dxgr.fsf@mozart.stat.wisc.edu>
	<m37l5rggmm.fsf@linux.local> <vbasnoeeajg.fsf@mozart.stat.wisc.edu>
	<qww1yv4bxdg.fsf@sap.com> <vbaelz4qo0n.fsf@mozart.stat.wisc.edu>
Organisation: SAP LinuxLab
Date: 20 Dec 2000 08:30:05 +0100
In-Reply-To: buhr@stat.wisc.edu's message of "19 Dec 2000 12:11:52 -0600"
Message-ID: <qwwwvcv8s8y.fsf@sap.com>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin,

On 19 Dec 2000, Kevin Buhr wrote:
> The code in Enlightenment did a complete
> shmget/shmat/shmctl(RMID)/shmdt cycle, so that segment *was* being
> constantly deleted.  The Mozilla ones stuck around.  The particular
> address that was being reference in the shm_nopage_core call
> corresponded to the segments being created and deleted by
> Enlightenment, however.

OK. The test with the complete cycle did run now for the whole night
on 13-pre3 + my patch. Seems to be stable for me.

Greetings
		Christoph

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
