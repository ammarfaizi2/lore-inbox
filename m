Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261435AbVARVTQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261435AbVARVTQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 16:19:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261430AbVARVSc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 16:18:32 -0500
Received: from ext-nj2gw-1.online-age.net ([216.35.73.163]:53695 "EHLO
	ext-nj2gw-1.online-age.net") by vger.kernel.org with ESMTP
	id S261428AbVARVSO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 16:18:14 -0500
From: "Kiniger, Karl (GE Healthcare)" <karl.kiniger@med.ge.com>
To: linux-kernel@vger.kernel.org
Date: Tue, 18 Jan 2005 22:18:01 +0100
Subject: raid 1 - automatic 'repair' possible?
Message-ID: <20050118211801.GA28400@wszip-kinigka.euro.med.ge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

it has now happened five times to me and now the
threshold to write to this list has been reached :-) :
(kernel 2.4.21-9.TLsmp BTW)

idea for enhancement of software raid 1:

every time the raid determines that a sector cannot
be read it could at least try to overwrite the bad are
with good data from the other disk.

Doing a re-sync of the raid happened to make the failed disk
error free again. (its a 200 GB disk and re-syncing
takes some time).

in all cases a smart scan showed the sector really as bad
and after resync it was readable again and smart
scanning was error free again.

i already had the disk replaced in the past (same model,
Model=Maxtor 6Y200P0, FwRev=YAR41BW0, SerialNo=Y63J7TSE)
the disk is not hot (smart shows 19 celsius which may
be correct since the room is air conditioned) and
the bad sectors were not that close together on
the surface:

# 1  Extended off-line   Completed: read failure       40%      3512         0x02ab8a02
# 6  Extended off-line   Completed: read failure       40%      2308         0x00057a35
# 9  Extended off-line   Completed: read failure       40%      2291         0x01b63b6a
#11  Extended off-line   Completed: read failure       40%      1861         0x01f67b1a
#18  Extended off-line   Completed: read failure       40%       679         0x01d7052a

interesting: (look at Reallocated_Sector_Ct - it is still zero...)

  4 Start_Stop_Count        0x0032   253   253   000    Old_age      -       3
  5 Reallocated_Sector_Ct   0x0033   253   253   063    Pre-fail     -       0
  6 Read_Channel_Margin     0x0001   253   253   100    Pre-fail     -       0

What do you think? Ideas welcome.

Greetings and thanks for your time,
Karl

-- 
Karl Kiniger   mailto:karl.kiniger@med.ge.com
GE Medical Systems Kretztechnik GmbH & Co OHG
Tiefenbach 15       Tel: (++43) 7682-3800-710
A-4871 Zipf Austria Fax: (++43) 7682-3800-47
