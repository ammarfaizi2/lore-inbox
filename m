Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262042AbRFDWbb>; Mon, 4 Jun 2001 18:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262164AbRFDWbV>; Mon, 4 Jun 2001 18:31:21 -0400
Received: from inet-mail4.oracle.com ([148.87.2.204]:7835 "EHLO
	inet-mail4.oracle.com") by vger.kernel.org with ESMTP
	id <S262042AbRFDWbL>; Mon, 4 Jun 2001 18:31:11 -0400
Message-ID: <3B1C0EAD.B0C83157@oracle.com>
Date: Mon, 04 Jun 2001 15:41:49 -0700
From: Radhakrishnan Manga <Radhakrishnan.Manga@oracle.com>
Reply-To: Radhakrishnan.Manga@oracle.com
X-Mailer: Mozilla 4.72 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: vmstat help
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  I am using the vmstat that came along with the SuSE 7.0 distribution.
I have problem interpretting the data reported by vmstat. The vmstat
document reads that the block information reported is always in terms of
1K blocks. Just to findout the validity of  the data reported by vmstat,
I carried out the a small copy test.  Here is the configuration I have

1) I have two file systems which are created with 4096 block size
2) These two file systems are on two different disks. (but both are
sitting on same scsi controller)
3) I am trying to copy a 4GB file from one disk to another using the
simple "cp" command.
4) I am capturing vmstat with 30 sec interval. I stop the vmstat after
cp is done
5) The copy takes anywhere between 7 to 10 minutes.

On vmstat report has bi and bo's ranging form 700 to 4000.

Just to get the total blocks read, I multiple the value reported in bi
column with 30 (as 30 sec was my sampling interval) and sum them all. To
my surprise, they add up only to around (1 GB).

  What is wrong here, the documentation or my intepretation of vmstat
output.



