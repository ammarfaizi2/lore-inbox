Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270757AbTHANzH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 09:55:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270760AbTHANzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 09:55:07 -0400
Received: from [65.244.37.61] ([65.244.37.61]:13755 "EHLO
	WSPNYCON1IPC.corp.root.ipc.com") by vger.kernel.org with ESMTP
	id S270757AbTHANzD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 09:55:03 -0400
Message-ID: <170EBA504C3AD511A3FE00508BB89A920234CD6C@exnanycmbx4.ipc.com>
From: "Downing, Thomas" <Thomas.Downing@ipc.com>
To: "'Stuart Longland'" <stuartl@longlandclan.hopto.org>,
       linux-kernel@vger.kernel.org
Subject: RE: fun or real: proc interface for module handling?
Date: Fri, 1 Aug 2003 09:54:24 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Stuart Longland [mailto:stuartl@longlandclan.hopto.org]
> On Thu, Jul 31, 2003 at 02:34:01PM +0200, Måns Rullgård wrote:
> 
> | Nico Schottelius <nico-kernel@schottelius.org> writes:
> | > Modul options could be passed my
> | >   echo "psmouse_noext=1" > /proc/mods/psmouse/options
> | > which would also make it possible to change module options while
> running..
> |
> | How would options be passed when loading?  Some modules require that
> | to load properly.
> 
> Possibility, why not just have a file, /proc/mods/initial, that you
> write the initial kernel module options to, e.g.
> 
> # echo "ne2000 io=0x300 irq=11" > /proc/mods/initial
> 
> Then you load the module using:
> 
> # mkdir /proc/mods/ne2000/
> 
> although you could skip this necessity and just load the module when
> someone writes to /proc/mods/initial.
> 
> Just a thought.

>From an newbie:

How about having a dir for each available module created earliest moment
in boot process, (point where depmod is done now I guess).  Each dir has
files 'options' and 'load'.  then you could:

# echo "io=0x300 irq=11" > /proc/mods/ne2000/options

followed by

# echo "1" > /proc/mods/ne2000/load

Of course, I am probably missing the point or something :-(

td
