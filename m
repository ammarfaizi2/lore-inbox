Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287500AbSAHAZM>; Mon, 7 Jan 2002 19:25:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287513AbSAHAXp>; Mon, 7 Jan 2002 19:23:45 -0500
Received: from jalon.able.es ([212.97.163.2]:14264 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S287499AbSAHAX0>;
	Mon, 7 Jan 2002 19:23:26 -0500
Date: Tue, 8 Jan 2002 01:27:34 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: jtv <jtv@xs4all.nl>
Cc: Tim Hollebeek <tim@hollebeek.com>,
        Bernard Dautrevaux <Dautrevaux@microprocess.com>,
        "'dewar@gnat.com'" <dewar@gnat.com>, paulus@samba.org, gcc@gcc.gnu.org,
        linux-kernel@vger.kernel.org, trini@kernel.crashing.org,
        velco@fadata.bg
Subject: Re: [PATCH] C undefined behavior fix
Message-ID: <20020108012734.E23665@werewolf.able.es>
In-Reply-To: <17B78BDF120BD411B70100500422FC6309E402@IIS000> <20020107224907.D8157@xs4all.nl> <20020107172832.A1728@cj44686-b.reston1.va.home.com> <20020107231620.H8157@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20020107231620.H8157@xs4all.nl>; from jtv@xs4all.nl on Mon, Jan 07, 2002 at 23:16:20 +0100
X-Mailer: Balsa 1.3.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20020107 jtv wrote:
>
>Let's say we have this simplified version of the problem:
>
>	int a = 3;
>	{
>		volatile int b = 10;

    >>>>>>>>> here b changes

>		a += b;
>	}
>
>Is there really language in the Standard preventing the compiler from
>constant-folding this code to "int a = 13;"?
>

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.2 (Cooker) for i586
Linux werewolf 2.4.18-pre1-beo #1 SMP Fri Jan 4 02:25:59 CET 2002 i686
