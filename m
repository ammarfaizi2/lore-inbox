Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270673AbTHAFzu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 01:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270674AbTHAFzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 01:55:50 -0400
Received: from 202-47-55-78.adsl.gil.com.au ([202.47.55.78]:60289 "HELO
	longlandclan.hopto.org") by vger.kernel.org with SMTP
	id S270673AbTHAFzs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 01:55:48 -0400
Message-ID: <3F2A00E1.1050701@longlandclan.hopto.org>
Date: Fri, 01 Aug 2003 15:55:45 +1000
From: Stuart Longland <stuartl@longlandclan.hopto.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4b) Gecko/20030507
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: fun or real: proc interface for module handling?
References: <20030731121248.GQ264@schottelius.org> <yw1xptjqub7q.fsf@users.sourceforge.net> <20030731231501.GC23607@pegasys.ws>
In-Reply-To: <20030731231501.GC23607@pegasys.ws>
X-Enigmail-Version: 0.75.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Thu, Jul 31, 2003 at 02:34:01PM +0200, Måns Rullgård wrote:

| Nico Schottelius <nico-kernel@schottelius.org> writes:
| > Modul options could be passed my
| >   echo "psmouse_noext=1" > /proc/mods/psmouse/options
| > which would also make it possible to change module options while
running..
|
| How would options be passed when loading?  Some modules require that
| to load properly.

Possibility, why not just have a file, /proc/mods/initial, that you
write the initial kernel module options to, e.g.

# echo "ne2000 io=0x300 irq=11" > /proc/mods/initial

Then you load the module using:

# mkdir /proc/mods/ne2000/

although you could skip this necessity and just load the module when
someone writes to /proc/mods/initial.

Just a thought.

- --
+-------------------------------------------------------------+
| Stuart Longland           stuartl at longlandclan.hopto.org |
| Brisbane Mesh Node: 719             http://stuartl.cjb.net/ |
| I haven't lost my mind - it's backed up on a tape somewhere |
| Griffith Student No:           Course: Bachelor/IT (Nathan) |
+-------------------------------------------------------------+
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE/KgDhIGJk7gLSDPcRAngeAJ4mUbQGQaijQbelNW8/6nXkdT+P+wCfUJ3U
I6J5l/5TS3UTrQlJb/D86YM=
=MIdk
-----END PGP SIGNATURE-----

