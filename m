Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263104AbRFGUkW>; Thu, 7 Jun 2001 16:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263106AbRFGUkN>; Thu, 7 Jun 2001 16:40:13 -0400
Received: from kerberos2.troja.mff.cuni.cz ([195.113.28.3]:26996 "HELO
	kerberos2.troja.mff.cuni.cz") by vger.kernel.org with SMTP
	id <S263104AbRFGUkA>; Thu, 7 Jun 2001 16:40:00 -0400
Received: from argo.troja.mff.cuni.cz (195.113.28.11)
  by vger.kernel.org with SMTP; 7 Jun 2001 20:39:43 -0000
Date: Thu, 7 Jun 2001 22:39:43 +0200 (MET DST)
From: Pavel Kankovsky <peak@argo.troja.mff.cuni.cz>
To: linux-kernel@vger.kernel.org
Subject: PTRACE_ATTACH breaks wait4()
Message-ID: <20010607223921.D94.0@argo.troja.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Let A be a process and B its child. When another process, let's call
it C, does ptrace(PTRACE_ATTACH) on B, wait4(pid of B, ...) will always
return ECHILD when invoked from A after B has been attached to C because
wait4() does not take children traced by other processes into account.
The problem was observed on 2.2.19. I suppose it exists in 2.4 as well.

Apparently, I am not the first person who encountered this problem. See
<http://www.uwsg.indiana.edu/hypermail/linux/kernel/9901.3/0869.html>

--Pavel Kankovsky aka Peak  [ Boycott Microsoft--http://www.vcnet.com/bms ]
"Resistance is futile. Open your source code and prepare for assimilation."


