Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265937AbUAUMct (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 07:32:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265943AbUAUMcs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 07:32:48 -0500
Received: from smtp2.dei.uc.pt ([193.137.203.229]:32186 "EHLO smtp2.dei.uc.pt")
	by vger.kernel.org with ESMTP id S265937AbUAUMcn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 07:32:43 -0500
Date: Wed, 21 Jan 2004 12:31:21 +0000 (WET)
From: "Marcos D. Marado Torres" <marado@student.dei.uc.pt>
To: Andi Kleen <ak@suse.de>
cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, vojtech@suse.cz
Subject: Re: mouse configuration in 2.6.1
In-Reply-To: <20040121132337.7f8d3c79.ak@suse.de>
Message-ID: <Pine.LNX.4.58.0401211228300.25485@student.dei.uc.pt>
References: <p73r7xwglgn.fsf@verdi.suse.de> <20040121043608.6E4BB2C0CB@lists.samba.org>
 <20040121132337.7f8d3c79.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-UC-DEI-MailScanner-Information: Please contact helpdesk@dei.uc.pt for more information
X-UC-DEI-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Wed, 21 Jan 2004, Andi Kleen wrote:

> On Wed, 21 Jan 2004 15:06:57 +1100
> Rusty Russell <rusty@rustcorp.com.au> wrote:
>
> > In message <p73r7xwglgn.fsf@verdi.suse.de> you write:
> > > Rusty Russell <rusty@rustcorp.com.au> writes:
> > >
> > > > Migrating to module_param() is the Right Thing here IMHO, which actually
> > > > takes the damn address,
> > >
> > > The main problem is that module_parm renames the boot time arguments and
> > > makes them long and hard to remember.
> >
> > Um, if the module name is neat, and the parameter name is neat, the
> > combination of the two with a "."  between them will be nest.
>
> Unfortunately we have lots of non neat module names and many previous boot
> time arguments note their subsystem which adds even more redundancy.
>
> And you're suggesting people to move to module_parm now in the stable
> series leads to renaming of module parameters, which breaks previously
> working configurations in often subtle ways. Maybe that's acceptable
> in a unstable development kernel, but I don't think it is in 2.6.
>
> How about adding a "setup option alias" table and require that everybody
> changing an existing __setup to module_parm adds an alias there?
>
> > > E.g. the new argument needed to make the mouse work on KVMs is
> > > mindboogling, could be nearly a Windows registry entry.
> >
> > I have no idea what you are talking about. 8(
>
> psmouse_base.psmouse_noext
>
> (brought to you by the department of redundancy department)
>
> The "new" and "improved" version is apparently:
>
> psmouse_base.psmouse_proto=bare

Actually it's psmouse.proto=bare

> which is even worse.
>
> And 2.6.0 -> 2.6.1 silently changing to that without any documentation anywhere,
> silently breaking my mouse. And debugging it requires a lot of reboots
> because we have regressed to Windows state where every mouse setting change
> requires a reboot :-/
>
> Sorry Rusty. You are probably the wrong target for the flame, but a combination
> of probably well intended changes including module_parm brought a total usability
> disaster here.
>
> -Andi
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


- --
==================================================
Marcos Daniel Marado Torres AKA Mind Booster Noori
/"\               http://student.dei.uc.pt/~marado
\ /                       marado@student.dei.uc.pt
 X   ASCII Ribbon Campaign
/ \  against HTML e-mail and Micro$oft attachments
==================================================

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Made with pgp4pine 1.76

iD8DBQFADnEbmNlq8m+oD34RAmatAKCBEpHzK1KzpmOQ6T8fveaL5j6bJgCeP+AA
N57BBoKD2an9Cg3ifJVYvh0=
=ikyB
-----END PGP SIGNATURE-----

