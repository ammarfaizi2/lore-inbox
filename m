Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293390AbSB1OH3>; Thu, 28 Feb 2002 09:07:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293086AbSB1OEz>; Thu, 28 Feb 2002 09:04:55 -0500
Received: from mail.linpro.no ([213.203.57.2]:38922 "HELO linpro.no")
	by vger.kernel.org with SMTP id <S293341AbSB1OCz> convert rfc822-to-8bit;
	Thu, 28 Feb 2002 09:02:55 -0500
To: linux-kernel@vger.kernel.org
Subject: [BUG] capabilities
From: knobo@linpro.no
Date: 28 Feb 2002 15:02:49 +0100
Message-ID: <ujpu1s1901i.fsf@ping.linpro.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Dropping the capability CAP_FSETID by itself does not work (and that
is probably correct), but when I drop CAP_CHOWN, CAP_FSETID works for
the group id, but not user id. I guess this is a bug (ref
include/linux/capability.h).


It does not look like dropping the CAP_SETGID (dropping CAP_SETGID
works in combination with dropping CAP_CHOWN) and CAP_SETUID works
either. Maybe they need to be dropped in combination with some other
capability? If so, it shod be more clear in the documentation
(cabability.h).

-- 
Knut Olav Bøhmer
         _   _
       / /  (_)__  __ ____  __
      / /__/ / _ \/ // /\ \/ /  ... The choice of a
     /____/_/_//_/\.,_/ /_/\.\         GNU generation

export PAGER="od -x |less"
