Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129811AbQKUMu5>; Tue, 21 Nov 2000 07:50:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130407AbQKUMur>; Tue, 21 Nov 2000 07:50:47 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:6149
	"EHLO ani.animx.eu.org") by vger.kernel.org with ESMTP
	id <S129811AbQKUMuc>; Tue, 21 Nov 2000 07:50:32 -0500
Date: Tue, 21 Nov 2000 07:29:47 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: linux-kernel@vger.kernel.org
Subject: 2.4.0-test11 failure on sparc
Message-ID: <20001121072947.A2512@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The changes between test10 and test11 broke st.o, nfs.o, runrpc.o and
lockd.o  It's the same unresolved symbol every time:

# insmod st
Using /lib/modules/2.4.0-test11/kernel/drivers/scsi/st.o
/lib/modules/2.4.0-test11/kernel/drivers/scsi/st.o: unresolved symbol __up
/lib/modules/2.4.0-test11/kernel/drivers/scsi/st.o: unresolved symbol __down_interruptible
/lib/modules/2.4.0-test11/kernel/drivers/scsi/st.o: unresolved symbol __down
# insmod sunrpc 
Using /lib/modules/2.4.0-test11/kernel/net/sunrpc/sunrpc.o
/lib/modules/2.4.0-test11/kernel/net/sunrpc/sunrpc.o: unresolved symbol __up
/lib/modules/2.4.0-test11/kernel/net/sunrpc/sunrpc.o: unresolved symbol __down
#

Other than that, seems to work just fine.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
