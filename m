Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261678AbRESHEs>; Sat, 19 May 2001 03:04:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261679AbRESHEi>; Sat, 19 May 2001 03:04:38 -0400
Received: from skif.spylog.com ([194.67.35.250]:40515 "HELO skif.spylog.com")
	by vger.kernel.org with SMTP id <S261678AbRESHE2>;
	Sat, 19 May 2001 03:04:28 -0400
Date: Sat, 19 May 2001 11:04:12 +0400
From: Peter Zaitsev <pz@spylog.ru>
X-Mailer: The Bat! (v1.51)
Reply-To: Peter Zaitsev <pz@spylog.ru>
Organization: http://www.spylog.ru
X-Priority: 3 (Normal)
Message-ID: <195243776381.20010519110412@spylog.ru>
To: linux-kernel@vger.kernel.org
Subject: Linux RAID5 issues.
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello linux-kernel,

  I'm using software raid5 on about 30 servers, and Yet twice I had a
  serious data loss becouse of the behavior of  linux RAID device.

    In several cases I've got more then one of drives completely
  disconnected. I have no ideas why this happened but this had
  something to do with new AHA controler drivers and enabled TCQ.
  After reboot all drivers turned back.
    Other options for this to happen may be a controler failure, then
  array is on several of them.

  The linux RAID behavior in this case was to still allow write to the
  array, so what only writes to online drives there made.  This have
  produced a huge mess on the drive after half an hour of running in
  this mode.

  The better solution I  think would be block writes to the array
  after second drive fail. This would at least give users more
  recovery options.

  
  
  

-- 
Best regards,
 Peter                          mailto:pz@spylog.ru


