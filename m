Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312634AbSDAWWx>; Mon, 1 Apr 2002 17:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312638AbSDAWWo>; Mon, 1 Apr 2002 17:22:44 -0500
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:28178 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S312634AbSDAWW3>;
	Mon, 1 Apr 2002 17:22:29 -0500
Date: Mon, 1 Apr 2002 14:21:28 -0800
From: Greg KH <greg@kroah.com>
To: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        linux-usb-devel@lists.sourceforge.net,
        Linux-usb-users@lists.sourceforge.net
Subject: [ANNOUNCE] 2002-03-01 release of hotplug scripts
Message-ID: <20020401222127.GB32079@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Mon, 04 Mar 2002 20:08:15 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I've just packaged up the latest Linux hotplug scripts into a release,
which can be found at:
 	http://sourceforge.net/project/showfiles.php?group_id=3D17679

Or from your favorite kernel.org mirror at:
	kernel.org/pub/linux/utils/kernel/hotplug/hotplug-2002_04_01.tar.gz

I've also packaged up a Red Hat 7.2 based rpm:
	kernel.org/pub/linux/utils/kernel/hotplug/hotplug-2002_04_01-1.noarch.rpm
=20
The source rpm is available if you want to rebuild it for other distros
at:
	kernel.org/pub/linux/utils/kernel/hotplug/hotplug-2002_04_01-1.src.rpm

The main web site for the linux-hotplug project can be found at:
	http://linux-hotplug.sf.net/
which contains lots of documentation on the whole linux-hotplug
process.  There are also links to kernel patches, not currently in the
main kernel tree, that provide hotplug functionality to new subsystems
(like CPU, SCSI, Memory, etc.)

The main changes in this release are the following:
	- fixed potential temp file security exploit in the ieee1394
	  script.
	- removed the fxload program from the package, moving back to
	  one package that is processor neutral (scripts only.)  fxload
	  can now be released on its own, separate from the main
	  package.

Here's the changes (and who made them) from the last release:

  Changes from David Brownell
        - hotplug.functions: always run setup scripts
        - ieee1394.agent: rm another explicit /etc/hotplug pathname
        - usb.agent: doesn't skip usb.usermap
        - usb.rc: hooks for other "new style" HCDs (2.5)
        - distro should now include /etc/hotplug/{usb,pci} directories
        - remove obsolete USBD_ENABLE option
        - comments/diagnostics say "usbfs" not "usbdevfs"
        - various comment/doc updates, including for USB "coldplug"
        - fxload:
            * fix bug in handling first hex record: nothing to merge with!
            * add '-Wall' to build and resolve warnings
            * Makefile installs fxload.8 man page

  Changes from Fumitoshi UKAI
        - etc/hotplug/ieee1394.agent: fix /tmp writable check
        - usb.agent: match algorithm in usb_map_modules() should be the=20
                     same as in kernel.
       =20
  Changes from me
        - usb.rc: updated the list of modules that we should be trying to
          remove.
        - moved fxload to a separate directory, out of this package.
        - updated the Makefile and .spec file to handle fxload moving away
        - cleaned Makefile up, now 'make distrib' works much nicer.
        - applied some minor cleanup patches from Landon Curt Noll.
        - ieee1394.agent: made more like other .agent files.  Removed /tmp
          check entirely as it's not needed.

thanks,

greg k-h

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8qN1mMUfUDdst+ykRAtiiAJ0cbJPYB79vyRNiJE5NDEFQlOWHiwCfUEok
cqJtR8QCODLILBX6MWOkL68=
=Mosz
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--
