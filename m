Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129143AbRDBN1Q>; Mon, 2 Apr 2001 09:27:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129166AbRDBN1G>; Mon, 2 Apr 2001 09:27:06 -0400
Received: from mailserver-ng.cs.umbc.edu ([130.85.100.230]:53412 "EHLO
	mailserver-ng.cs.umbc.edu") by vger.kernel.org with ESMTP
	id <S129143AbRDBN0z>; Mon, 2 Apr 2001 09:26:55 -0400
To: linux-kernel@vger.kernel.org
Subject: /proc/config idea
From: Ian Soboroff <ian@cs.umbc.edu>
Emacs: where editing text is like playing Paganini on a glass harmonica.
Date: 02 Apr 2001 09:25:55 -0400
Message-ID: <877l13whzw.fsf@danube.cs.umbc.edu>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[sorry this doesn't have proper References: headers, i read the list
off the hypermail archive.]

there was some discussion of whether the kernel should emit a
/proc/config or some such for purposes of bug reporting, but that
seems to be a lot of bloat.

instead, why not try to point to a canonical location for a config
copy (we already basically do this with ksymoops and System.map), and
instead have a /proc/config-hash which emits a (precomputed) MD5 hash
of the .config file it was compiled with?

this way, you could check possible configs (Debian for example likes
to stash a copy in /boot, like System.map) and also know if they were
the right ones.

the one problem that comes to mind right now is modules, which needn't
correspond to a full kernel .config.

anyway, my $0.02.
ian

-- 
----
Ian Soboroff                                       ian@cs.umbc.edu
University of MD Baltimore County      http://www.cs.umbc.edu/~ian
