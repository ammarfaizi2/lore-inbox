Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261497AbTENDzg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 23:55:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261753AbTENDzg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 23:55:36 -0400
Received: from customer-148-223-196-18.uninet.net.mx ([148.223.196.18]:9609
	"EHLO soltisns.soltis.cc") by vger.kernel.org with ESMTP
	id S261497AbTENDzd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 23:55:33 -0400
From: "jds" <jds@soltis.cc>
To: jbj@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Fw: Fwd: rpm-4.2, rpm-4.1.1, rpm-4.0.5, librpm404-4.0.5 release (finally)
Date: Tue, 13 May 2003 21:31:55 -0600
Message-Id: <20030514032627.M2802@soltis.cc>
In-Reply-To: <20030514033509.GB30447@ip68-101-124-193.oc.oc.cox.net>
References: <20030514033509.GB30447@ip68-101-124-193.oc.oc.cox.net>
X-Mailer: Open WebMail 1.90 20030212
X-OriginatingIP: 200.78.44.117 (jds)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Hi:

   Im try with new version rpm, both have is the same error:

   RH 9.0   kernel 2.5.69mm3
   Update the packages rpm-*4.2-1, popt, etc.
   
   [root@toshiba root]# rpm -qa
rpmdb: unable to join the environment
error: db4 error(11) from dbenv->open: Resource temporarily unavailable
error: cannot open Packages index using db3 - Resource temporarily unavailable
(11)
error: cannot open Packages database in /var/lib/rpm
no packages
[root@toshiba root]#

   When put export LD_ASSUME_KERNEL=2.4.1 

   The rpm -qa working good.

   Regards.


---------- Forwarded Message -----------
From: "Barry K. Nathan" <barryn@pobox.com>
To: linux-kernel@vger.kernel.org
Sent: Tue, 13 May 2003 20:35:09 -0700
Subject: Fwd: rpm-4.2, rpm-4.1.1, rpm-4.0.5, librpm404-4.0.5 release (finally)

Since there have been some posts recently about the RPM/O_DIRECT stuff,
I think this announcement might be relevant...

Normally I would just post a URL to the announcement, but the list
archive is only available to members of the list.

-Barry K. Nathan <barryn@pobox.com>

----- Forwarded message from Jeff Johnson <jbj@redhat.com> -----

X-Original-To: barryn@localhost
Delivered-To: barryn@localhost.oc.oc.cox.net
From: Jeff Johnson <jbj@redhat.com>
To: rpm-list@redhat.com
Subject: rpm-4.2, rpm-4.1.1, rpm-4.0.5, librpm404-4.0.5 release (finally)
User-Agent: Mutt/1.2.5.1i
X-Loop: rpm-list@redhat.com
Errors-To: rpm-list-admin@redhat.com
X-BeenThere: rpm-list@redhat.com
X-Mailman-Version: 2.0.13
Precedence: bulk
Reply-To: rpm-list@redhat.com
List-Help: <mailto:rpm-list-request@redhat.com?subject=help>
List-Post: <mailto:rpm-list@redhat.com>
List-Subscribe: <https://www.redhat.com/mailman/listinfo/rpm-list>,
	<mailto:rpm-list-request@redhat.com?subject=subscribe>
List-Id: RPM Package Manager <rpm-list.redhat.com>
List-Unsubscribe: <https://www.redhat.com/mailman/listinfo/rpm-list>,
	<mailto:rpm-list-request@redhat.com?subject=unsubscribe>
List-Archive: <https://www.redhat.com/mailman/private/rpm-list/>
Date: Tue, 13 May 2003 19:03:21 -0400

Rpm 4.2 (for Red Hat 9) is now available at
        ftp://ftp.rpm.org/pub/rpm/dist/rpm-4.2.x

Rpm-4.1.1 (for Red Hat 8.0) is now available at
        ftp://ftp.rpm.org/pub/rpm/dist/rpm-4.1.x

Rpm-4.0.5 (for Red Hat 7.3) is now available at
        ftp://ftp.rpm.org/pub/rpm/dist/rpm-4.0.x

librpm404-4.0.5 (for Red Hat 8.0) is also available at
        ftp://ftp.rpm.org/pub/rpm/dist/librpm404

Note carefully that all these packages are signed with my key, not with
Red Hat's RPM-GPG-KEY, so you will also need to download and import the
	JBJ-GPG-KEY
file located in all the directories mentioned above.

These version(s) are available through anonymous cvs:
        cvs -d :pserver:anonymous@cvs.rpm.org:/cvs/devel login
        (no password, just carriage return)
        cvs -d :pserver:anonymous@cvs.rpm.org:/cvs/devel get rpm
        cd rpm
on the appropriate rpm-4_2, rpm-4_1, rpm-4_0 banches.

Please report any difficulties, problems, issues, feature requests, whatever at
        http://bugzilla.redhat.com

See the changelogs, or the file CHANGES, for details of the changes.

This is a lot of packages on a lot of platforms to be releasing simultaneously,
so here's some notes about how to choose the appropriate version for your needs.

Note carefully that the choice is not as simple as
	Choose the latest available version

The first, and most important, criteria is
	If you are not running a NPTL aware kernel/glibc combination,
	then use rpm-4.1.1, not rpm-4.2. "NPTL" basically means that
	you are using Red Hat 9, or have the Red Hat 9 kernel/glibc packages
	installed.
Both rpm-4.2 and rpm-4.1.1 are from the same code base, but have been compiled
differently.

The other important criteria is
	If you are not interested in forward compatibility of rpm on Red Hat
	7.3 (and almost nobody is), then you don't need to install rpm-4.0.5.
The issue is that db-4.1.25 is backward compatible with db-4.0.14, but
db-4.0.14 is not forward compatible with db-4.1.25. So, to provide forward
compatibility, I've backported db-4.1.25 underneath rpm-4.0.4. There are
no other interesting or useful changes from rpm-4.0.4, as this is basically
end-of-development-life for rpm-4.0.x, no further development is anticiapted.

The same forward compatibility issue applies to librpm404-4.0.5. This
basically means that
	If you upgrade a Red Hat 8.0 box to rpm-4.1.1, then you should
	also upgrade to librpm404-4.0.5. This is particularly important
	if you are using, redcarpet or yum.

Feel free to ask here on rpm-list if there are problems and/or issues.

There's always something, and this time for sure.

73 de Jeff

-- 
Jeff Johnson	ARS N3NPQ
jbj@redhat.com (jbj@jbj.org)
Chapel Hill, NC

_______________________________________________
Rpm-list mailing list
Rpm-list@redhat.com
https://www.redhat.com/mailman/listinfo/rpm-list

----- End forwarded message -----
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
------- End of Forwarded Message -------



