Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267339AbSKPTHm>; Sat, 16 Nov 2002 14:07:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267340AbSKPTHm>; Sat, 16 Nov 2002 14:07:42 -0500
Received: from 12-231-236-219.client.attbi.com ([12.231.236.219]:11995 "EHLO
	mystic.osdl.org") by vger.kernel.org with ESMTP id <S267339AbSKPTHl>;
	Sat, 16 Nov 2002 14:07:41 -0500
From: Nathan <smurf@osdl.org>
Date: Sat, 16 Nov 2002 11:14:39 -0800
To: Dan Kegel <dank@kegel.com>
Cc: john slee <indigoid@higherplane.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Why can't Johnny compile?
Message-ID: <20021116191439.GB12011@mystic.osdl.org>
References: <3DD5D93F.8070505@kegel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DD5D93F.8070505@kegel.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2002 at 09:35:59PM -0800, Dan Kegel wrote:
> Hrmph.  Y'know, maybe it's time for us to collectively put our
> feet down, get 2.5-linus to the point where everything compiles,
> and keep it there.  After all, we are supposedly trying to
> *stabilize* 2.5.  It isn't stable if it doesn't compile...

FYI, the OSDL has a "patch bot" system available that will do compile
verifications on patches.

Patches can be submitted against standard kernel releases or in a
depends-on fashion against other patches.

Six total compile configs are tried, UP & SMP of the following:

  - Default config
  - Desktop config (really just a bunch of stuff enabled)
  - STP config (required hardware support to run on the OSDL's STP)

When the tests are done running against your patch, you get a summary
email telling you which tests passed and which ones failed.

The system is at:  http://www.osdl.org/cgi-bin/plm

A sample page (kernel 2.5.47) is at:

  http://www.osdl.org/cgi-bin/plm?module=patch_info&patch_id=943

Another sample (kernel 2.4.20-rc2) is at:

  http://www.osdl.org/cgi-bin/plm?module=patch_info&patch_id=978

Note the filters at the bottom, clicking on the FAIL by desktop config
gives the .config used in the test followed by enough of the tail of the
compile log to tell what went wrong.

Patches in the PLM can then be used in benchmark runs in the STP.

The standard 2.4 and 2.5 trees are auto-added after they hit our ftp
mirror.

I am interested in modifying the "Desktop" config to mirror the average
user as well as putting in a new "all" when we have the ability to do
it (/lots/ of modules...)  People having suggestions on what to include
in the Desktop config, please speak up.

People can also download the patch content from the patch info page.

Thanks,
Nathan
