Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293521AbSCKWRw>; Mon, 11 Mar 2002 17:17:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293531AbSCKWRn>; Mon, 11 Mar 2002 17:17:43 -0500
Received: from [192.55.52.25] ([192.55.52.25]:8149 "EHLO caduceus.fm.intel.com")
	by vger.kernel.org with ESMTP id <S293521AbSCKWRj>;
	Mon, 11 Mar 2002 17:17:39 -0500
Message-ID: <59885C5E3098D511AD690002A5072D3C02AB7CD2@orsmsx111.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'urban@teststation.com'" <urban@teststation.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: smbfs and failed nls translations
Date: Mon, 11 Mar 2002 14:17:28 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[resending - fingers instinctually typed wrong lkml address last time]

<urban@teststation.com> (02/03/07 1.375.1.137)
	[PATCH] smbfs nls oops fix
	
	Fixes smbfs oopsing on failed nls translations and maps unknown
chars to
	:#### strings. Also PATHLEN vs NAMELEN mixups.

Hi, apparently my smbfs mounts have had failed nls translations, but I
didn't know it -- never saw any warnings. So when I upgraded to 2.5.6 that
included this patch, the filenames on my samba mounts all turned into
"x00:x00..." etc. ;-)

Turning off CONFIG_SMB_NLS_DEFAULT produces a different, but still failing,
result.

How can I get samba working again? What am I doing wrong? And, why is samba
so stingy with the error messages in this case?

Thanks -- Regards -- Andy

----------------------------
Andrew Grover
Intel Labs / Mobile Architecture
andrew.grover@intel.com



----------------------------
Andrew Grover
Intel Labs / Mobile Architecture
andrew.grover@intel.com

