Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282912AbRK0KaU>; Tue, 27 Nov 2001 05:30:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282899AbRK0KaI>; Tue, 27 Nov 2001 05:30:08 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:39186 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S282906AbRK0K3s>;
	Tue, 27 Nov 2001 05:29:48 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Harald Arnesen <gurre@start.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Release Policy 
In-Reply-To: Your message of "Tue, 27 Nov 2001 11:08:04 BST."
             <873d30r0fv.fsf@basilikum.skogtun.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 27 Nov 2001 21:29:36 +1100
Message-ID: <2515.1006856976@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Nov 2001 11:08:04 +0100, 
Harald Arnesen <gurre@start.no> wrote:
>Anuradha Ratnaweera <anuradha@gnu.org> writes:
>
>> How does Marcelo (or Linus or Alan, say) know that the patch
>> _really_ came from the subsystem aintainer himself?
>
>They could reject patches that came without the maintainers GPG or PGP
>signature.

Unfortunately the normal GPG/PGP signing changes '-' at start of line
to '- -', even with clear text signing, and destroys the patch.  You
have to use --not-dash-escaped in GPG, where the man page says:

--not-dash-escaped
  This  option changes the behavior of cleartext signatures so that
  they can be used for patch files. You should not send such an armored
  file via email because all spaces and line endings are hashed too.
  You can not use this option for data which has 5 dashes at the
  beginning of a line, patch files don't have this. A special armor
  header line tells GnuPG about this cleartext signature option.

I don't know if PGP accepts text signed by GPG with --not-dash-escaped
nor do I know if there really is a problem with mailing such patches.
But the warning above is nasty enough to rule it out.  The only other
option for signed patches is uuencode or MIME (with or without
compression) and Linus does not like that format.

