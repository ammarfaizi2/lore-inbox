Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272277AbRIETTN>; Wed, 5 Sep 2001 15:19:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272289AbRIETTF>; Wed, 5 Sep 2001 15:19:05 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:59151 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S272277AbRIETSr>; Wed, 5 Sep 2001 15:18:47 -0400
Date: Wed, 5 Sep 2001 21:18:52 +0200
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Ken Moffat <ken@kenmoffat.uklinux.net>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Patch: fix error in building procfs-guide
Message-ID: <20010905211851.N22160@arthur.ubicom.tudelft.nl>
In-Reply-To: <Pine.LNX.4.21.0109051939150.20371-100000@pppg_penguin.linux.bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0109051939150.20371-100000@pppg_penguin.linux.bogus>; from ken@kenmoffat.uklinux.net on Wed, Sep 05, 2001 at 07:44:29PM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2001 at 07:44:29PM +0100, Ken Moffat wrote:
> Following patch fixes errors which cause building kernel docs to fail
> (e.g. tulip user guide doesn't get built). Created on 2.4.7 while I was on
> holiday, applies cleanly to 2.4.9-ac6 and 2.4.10-pre4.

Thanks for spotting the error, the patch is obviously correct. Linus,
Alan, please apply.


Erik

> diff -urN linux-2.4.7/Documentation/DocBook/procfs-guide.tmpl altered-2.4.7/Documentation/DocBook/procfs-guide.tmpl
> --- linux-2.4.7/Documentation/DocBook/procfs-guide.tmpl	Sat Jul 21 22:47:23 2001
> +++ altered-2.4.7/Documentation/DocBook/procfs-guide.tmpl	Wed Aug 22 20:39:44 2001
> @@ -207,7 +207,7 @@
>          will return <constant>NULL</constant>. <xref
>          linkend="userland"> describes how to do something useful with
>          regular files.
> -      <para>
> +      </para>
>  
>        <para>
>          Note that it is specifically supported that you can pass a
> @@ -577,7 +577,7 @@
>          the <structfield>owner</structfield> field in the
>          <structname>struct proc_dir_entry</structname> to
>          <constant>THIS_MODULE</constant>.
> -      <para>
> +      </para>
>  
>        <programlisting>
>  struct proc_dir_entry* entry;
> 

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
