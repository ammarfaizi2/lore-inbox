Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263823AbTLTEBp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 23:01:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263824AbTLTEBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 23:01:45 -0500
Received: from smtp809.mail.sc5.yahoo.com ([66.163.168.188]:46242 "HELO
	smtp809.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263823AbTLTEBo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 23:01:44 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>,
       linux-kernel@vger.kernel.org
Subject: Re: psmouse synchronization loss under load
Date: Fri, 19 Dec 2003 23:01:37 -0500
User-Agent: KMail/1.5.4
References: <E1AXWpR-0000Zm-00@calista.eckenfels.6bone.ka-ip.net>
In-Reply-To: <E1AXWpR-0000Zm-00@calista.eckenfels.6bone.ka-ip.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200312192301.37809.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 19 December 2003 09:26 pm, Bernd Eckenfels wrote:
> In article <20031220015131.GB9834@vitelus.com> you wrote:
> > On a Dell laptop whenever I run a program that takes the full CPU, my
> > mouse pointer goes insane and thrashes my X session every few
> > minutes.
>
> On my older system with 2.6.0 kernel i have currently this problem,
> whenever APM tries to suspend the system. It will log that it was busy
> (screen shortly gets black) and after that the genius ps2 mouse behaves
> like you expected. Unplugging it helps.
>

You might want to give my input patches a try. Although they unlikely to fix
the problem that you can't suspend they should correctly restore keyboard
and mouse (PS/2) on resume (both APM and new suspend methods supported)
and I am very interested in results.

The patches are at http://www.geocities.com/dt_or/input 
They are against -test11 but I think will apply to 2.6.0-final.

Dmitry 
