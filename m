Return-Path: <linux-kernel-owner+w=401wt.eu-S1751956AbXARFjT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751956AbXARFjT (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 00:39:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751967AbXARFjT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 00:39:19 -0500
Received: from web7704.mail.in.yahoo.com ([202.86.4.42]:27563 "HELO
	web7704.mail.in.yahoo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751956AbXARFjS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 00:39:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.in;
  h=X-YMail-OSG:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=ZjDOVkpzx5WF6qSgTL0VfRgL1plltbfEdSVaA7npaI+7yZYwZqToY8/03lIXVgngBSJSl6x+3TZtK0dfvgrKCI48q1inlmF1SHaFD34bsl5NthSnJ020RNtWTnh4zyChUsZIIklKAMumyY4cdZTnRZvGfnE4AbAWP+TyvAEDN8Y=;
X-YMail-OSG: uobUTBwVM1mqNBgB7hfqrIMfiYs8EoMJGZRwtZ6rrEP6QrnmrkXf3U.AZyb2iB3IscMV9cZd.poDqylgLqJeExDr9JWXfmWPYsAsvQB3CLIcmya1Ttfq1R9LLwQOR2CH
Date: Thu, 18 Jan 2007 05:39:15 +0000 (GMT)
From: Seetharam Dharmosoth <seetharam_kernel@yahoo.co.in>
Subject: Re: query related to serial console
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20070117203421.6d80be93.randy.dunlap@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <526190.52452.qm@web7704.mail.in.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Randy Dunlap <randy.dunlap@oracle.com> wrote:

> On Thu, 18 Jan 2007 04:10:17 +0000 (GMT) Seetharam
> Dharmosoth wrote:
> 
> (please don't top-post)
> 
> 
> > Generally sysrq will work with serial console
> right?
> > 
> > suppose system is connected through serial port to
> the
> > other system, (ie serial console), at this time we
> can
> > fire some set of commands through the serial
> console.
> > 
> > the sequesnce is as follows  
> > do ctrl+]
> > send brk
> > then some commands
> > 
> > What is my question is con't we pass commands
> directly
> > 
> > to the console (without send brk signal) ?
> > 
> > This is a feature in Solris..
> > 
> > I am looking in Linux but, uable to find it.
> > 
> > can you please help me
> > 
> > Thanks
> > Seetharam
> 
> Hi,
> It's quite possible that I misunderstand your
> question,
> but anyway:
> 
> Alt-Sysrq-<key> is a route into the kernel sysrq
> handler instead
> of a route into the shell that the serial console is
> connected to,
> so something needs to signal that condition (like a
> BREAK).
> 
> Or a specialized (serial) console app could know
> other ways of
> recognizing sysrq keys.  Or you could use
> /proc/sysrq-trigger:
> 	echo b > /proc/sysrq-trigger
> 
Hi Randy,

It's ok.
Thanks for reply.

I have one doubt in this regard.
1) once we connected to the serial console we don't
   want to login into the shell.
   (without login into the shell we want to fire the
   sysrq command like b, r m, etc.)

 for this I am doing like 
  grabing the serial console then
  doing ctrl+]
  so that getting 
              telnet> 
now i want to give command like b, m ,r etc.

but it is not accepting my commands until I do 
telnet> send brk

can you please explain me why like this behavior ?

Thanks
Seetharam

  



> 
> > --- Erik Mouw <erik@harddisk-recovery.com> wrote:
> > 
> > > On Wed, Jan 17, 2007 at 11:26:54AM +0000,
> Seetharam
> > > Dharmosoth wrote:
> > > > Is Linux having 'non-break interface for
> serial
> > > > console' ?
> > > 
> > > No idea. Could you explain what a 'non-break
> > > interface for serial
> > > console' is?
> 
> 
> ---
> ~Randy
> 



		
__________________________________________________________
Yahoo! India Answers: Share what you know. Learn something new
http://in.answers.yahoo.com/
