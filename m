Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964916AbWDMNHc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964916AbWDMNHc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 09:07:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964919AbWDMNHc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 09:07:32 -0400
Received: from web35003.mail.mud.yahoo.com ([209.191.68.197]:8841 "HELO
	web35003.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964916AbWDMNHc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 09:07:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.br;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=11ucmHYzyhI5msO8H9untQfA9yRx3+tRiPNetL7epoYAUqUIJ8cybJKuJ8NvJQ+vx7jXH0G+ccWwTTKBgy1AToOuftYMisKpis4K1B92cCxBMqoBQBFQ3buNsjeT4Ry8yMdCjIHuT9sy6D+xlJWoxMUTRsxWR8g9VPKyUbBu20g=  ;
Message-ID: <20060413130729.84397.qmail@web35003.mail.mud.yahoo.com>
Date: Thu, 13 Apr 2006 13:07:29 +0000 (GMT)
From: =?iso-8859-1?q?Jos=E9=20Toneh?= <tohnehn@yahoo.com.br>
Subject: straced process appears in state `S' but still needs SIGCONT
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

After stracing mozilla-bin, I couldn't tell why the app
stopped working. The process state as shown in ps -l was
`T' during the whole trace, and went back to `S' after the
trace; nevertheless, mozilla was still unresponsive.

`killall -CONT mozilla-bin' solved the issue. So it seems
the process was still indeed in a stopped state, but the
kernel seems to have assumed a misled opinion on the subject.

I used different invokations of strace, including:

strace -cp 2348

and

strace -ewrite -p 2348 2>&1 | less -S

with the same results.

Regards

José Toneh


		
_______________________________________________________ 
Novidade no Yahoo! Mail: receba alertas de novas mensagens no seu celular. Registre seu aparelho agora! 
http://br.mobile.yahoo.com/mailalertas/ 
 

