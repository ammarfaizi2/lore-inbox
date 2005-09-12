Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932083AbVILUs0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083AbVILUs0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 16:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932228AbVILUsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 16:48:25 -0400
Received: from smtpout.mac.com ([17.250.248.46]:10690 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932083AbVILUsZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 16:48:25 -0400
In-Reply-To: <200509121003.11086.bjorn.helgaas@hp.com>
References: <4316E5D9.8050107@geograph.co.za> <20050901144812.GA3483@atrey.karlin.mff.cuni.cz> <20050911223619.GB19403@aitel.hist.no> <200509121003.11086.bjorn.helgaas@hp.com>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <F96CD1EB-5963-49CF-9B8B-7934925BE79D@mac.com>
Cc: Helge Hafting <helgehaf@aitel.hist.no>, Martin Mares <mj@ucw.cz>,
       Vojtech Pavlik <vojtech@suse.cz>,
       Zoltan Szecsei <zoltans@geograph.co.za>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: multiple independent keyboard kernel support
Date: Mon, 12 Sep 2005 16:47:28 -0400
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 12, 2005, at 12:03:11, Bjorn Helgaas wrote:
> On Sunday 11 September 2005 4:36 pm, Helge Hafting wrote:
>> Look again.  X config files now have "IsolateDevice" and "BusID"
>> to deal with this.  At least iff you get your X from ubuntu or
>> debian testing . . .
>
> Yes, but I think IsolateDevice still isn't quite enough if you
> have VGA devices behind PCI-PCI bridges.  In other words, devices
> behind bridges still get disabled, even with IsolateDevice.
>
> And the ideal situation would be if IsolateDevice could be the
> *default*, but the X bugzilla[1] says some devices have problems
> with that.

IIRC, someone was working on a VGA arbiter and some PCI-access kernel  
code
upon which X.org could be rebuilt.  Then all the messy /dev/mem issues
relating to PCI bus smashing go away (including the need for iopl, root
privts, etc), and a properly configured system could run X.org as a  
normal
user on any attached devices that user has permission to, including  
video
cards, displays, keyboards, mice, graphics tablets, joysticks, etc.

Unfortunately the project is not exactly small, so it wasn't moving very
quickly last I remember...

Cheers,
Kyle Moffett

--
Unix was not designed to stop people from doing stupid things,  
because that
would also stop them from doing clever things.
   -- Doug Gwyn


