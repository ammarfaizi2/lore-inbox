Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266995AbTBHN7O>; Sat, 8 Feb 2003 08:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266996AbTBHN7O>; Sat, 8 Feb 2003 08:59:14 -0500
Received: from smtp-out-2.wanadoo.fr ([193.252.19.254]:43705 "EHLO
	mel-rto2.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S266995AbTBHN7L>; Sat, 8 Feb 2003 08:59:11 -0500
Date: Sat, 8 Feb 2003 15:08:40 +0100
From: wwp <subscript@free.fr>
To: Toplica Tanaskovi <toptan@EUnet.yu>, linux-kernel@vger.kernel.org
Subject: Re: [Fwd: [ PATCH ] radeonfb and ATI Radeon R9000 (2.4.18)]
Message-Id: <20030208150840.0c4a26ae.subscript@free.fr>
In-Reply-To: <3E3C6A64.5020009@EUnet.yu>
References: <3E3C6A64.5020009@EUnet.yu>
X-Mailer: Sylpheed version 0.8.9claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Sat__8_Feb_2003_15:08:40_+0100_096e6060"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart_Sat__8_Feb_2003_15:08:40_+0100_096e6060
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Toplica Tanaskovi,


On Sun, 02 Feb 2003 01:46:28 +0100 Toplica Tanaskovi <toptan@EUnet.yu> wrote:

> 	Here is the patch for 2.4.18 kernel that adds ATI Radeon R9000 support
> 	to
> the Radeon Framebuffer driver, also fixes annoying console corruption
> when using fglrx and switching from X to console.
> 
> 	As I said this is a patch for 2.4.18, but I think that it will work
> 	with
> 2.4.19 and 2.4.20 too.

It seems that the radeon card ID you've added mismatches the ATI fglrx 
cards definition file.

Yours:
#define PCI_DEVICE_ID_RADEON_IG		0x4966

ATI fglrx 2.5.1 (last) BoardInfo.h (attached):
#define DEVICE_ID_RV250_IF       0x4966 // regular
#define DEVICE_ID_RV250_IG       0x4967 // regular

IF or IG so? What about this?
HTH


Regards,

-- 
wwp

--Multipart_Sat__8_Feb_2003_15:08:40_+0100_096e6060
Content-Type: text/plain;
 name="BoardInfo.h"
Content-Disposition: attachment;
 filename="BoardInfo.h"
Content-Transfer-Encoding: 7bit

#include <qglobal.h>
#include <qstring.h>

#define LOG_FILE   "/var/log/XFree86.0.log"

class CBoardInfo
{
  public:
            CBoardInfo ( ) ;
    bool    Init ( ) ;
    QString FamilyName    (  ) ;
    QString BoardName     (  ) ;
    QString BusType       (  ) ;
    QString BiosVersion   (  ) ;
    QString ChipType      (  ) ;
    QString ChipRevision  (  ) ;
    QString ChipSpeed     (  ) ;
    QString DacSpeed      (  ) ;
    QString MemoryType    (  ) ;
    QString MemorySize    (  ) ;
    QString MemorySpeed   (  ) ;
    QString TransferMode  (  ) ;
    QString DriverVersion (  ) ;
#ifdef FGLRX_OGL_INFO
    QString OGLVendor     (  ) ;
    QString OGLRenderer   (  ) ;
    QString OGLVersion    (  ) ;
#endif // FGLRX_OGL_INFO

  private:
    int     m_NumBoards ;
    QString m_FamilyName ;
    QString m_BoardName ;
    QString m_BIOSVersion ;
    QString m_ChipType ;
    QString m_ChipRevision ;
    int     m_DacSpeed ;
    QString m_MemoryType;
    int     m_MemorySize ;
    QString m_TransferMode ;
    QString m_DriverVersion ;
#ifdef FGLRX_OGL_INFO
    QString m_OGLVendor;
    QString m_OGLRenderer;
    QString m_OGLVersion;
#endif // FGLRX_OGL_INFO

};

// ATI device IDs
// === R200 ===
#define PCI_CHIP_R200_QH  0x5148  // Function 0, workstation. - current FGL boards
#define PCI_CHIP_R200_QI  0x5149  // Function 0, workstation. - for future use
#define PCI_CHIP_R200_QJ  0x514A  // Function 0, workstation. - for future use
#define PCI_CHIP_R200_QK  0x514B  // Function 0, workstation. - for future use 

#define PCI_CHIP_R200_QL  0x514C  // Function 0, regular.     - consumer div.
#define PCI_CHIP_R200_QT  0x516C  // Function 1, regular.     - consumer div.
#define PCI_CHIP_R200_BB  0x4242  // R200 chip on AiW board with bridget in PCI-PCI bridget mode.

#define PCI_CHIP_R200_QM	0x514D
#define PCI_CHIP_R200_QN	0x514E
#define PCI_CHIP_R200_QO	0x514F

// === RV250 ===
#define DEVICE_ID_RV250_ID       0x4964	// workstation
#define DEVICE_ID_RV250_IE       0x4965 // workstation
#define DEVICE_ID_RV250_IF       0x4966 // regular
#define DEVICE_ID_RV250_IG       0x4967 // regular

#define DEVICE_ID_RV250_IL       0x496C // workstation
#define DEVICE_ID_RV250_IM       0x496D // workstation
#define DEVICE_ID_RV250_IN       0x496E // regular
#define DEVICE_ID_RV250_IO       0x496F // regular

#define DEVICE_ID_RV250_LD       0x4C64 // mobile workstation
#define DEVICE_ID_RV250_LE       0x4C65 // mobile workstation
#define DEVICE_ID_RV250_LF       0x4C66 // mobile regular
#define DEVICE_ID_RV250_LG       0x4C67 // mobile regular

#define DEVICE_ID_RV250_LL       0x4C6C // mobile workstation
#define DEVICE_ID_RV250_LM       0x4C6D // mobile workstation
#define DEVICE_ID_RV250_LN       0x4C6E // mobile regular
#define DEVICE_ID_RV250_LO       0x4C6F // mobile regular

// === R300 ===
#define DEVICE_ID_R300_AD        0x4144
#define DEVICE_ID_R300_AE        0x4145
#define DEVICE_ID_R300_AF        0x4146
#define DEVICE_ID_R300_AG        0x4147 // WS

#define DEVICE_ID_R300_ND        0x4E44
#define DEVICE_ID_R300_NE        0x4E45
#define DEVICE_ID_R300_NF        0x4E46
#define DEVICE_ID_R300_NG        0x4E47 // WS

//
// Define ATI's internal revision numbers.
//
#define INTERNAL_REV_R300_A11           0x00
#define INTERNAL_REV_R300_A12           0x01
#define INTERNAL_REV_R300_A13           0x02

#define INTERNAL_REV_WS                 0x80

// board names
#define ADAPTER_NAME8700LE              "Fire GL 8700LE"
#define ADAPTER_NAME8700                "Fire GL 8700"
#define ADAPTER_NAME8800LE              "Fire GL 8800LE"
#define ADAPTER_NAME8800                "Fire GL 8800"
#define ADAPTER_NAMEE1                  "Fire GL E1"
#define ADAPTER_NAMEZ1AGPPRO            "Fire GL Z1"
#define ADAPTER_NAMEX1AGP               "Fire GL X1"
#define ADAPTER_NAMEX1AGPPRO            "Fire GL X1"

// ATI subedvice IDs for R200
#define SUBSYSTEMID_8700LE              0x0162  // 32 MB
#define SUBSYSTEMID_8700                0x0172  // 64 MB
#define SUBSYSTEMID_8800LE              0x010A  // 64 MB
#define SUBSYSTEMID_8800                0x0152  // 128 MB
#define SUBSYSTEMID_E1                  0x110A  // 64 MB

// ATI subedvice IDs for R300
#define SUBSYSTEMID_FIREGLZ1AGPPRO      0x010A  // 128 MB
#define SUBSYSTEMID_FIREGLX1AGPPRO      0x0152  // 128/256 MB
#define SUBSYSTEMID_OEM1_FIREGLX1AGP    0x0172  // 128 MB (?)

// misc defines
#define MEMORY_TYPE                     L"DDR SDRAM"
#define DAC_SPEED                       400

#define BIOS_PN_PREFIX                  "BIOS P/N "                 // ATI BIOS P/N prefix
#define BIOS_RAGE128_PREFIX             "ATI Technologies Inc. "    // ATI BIOS prefix for pre-production BIOS
#define BIOS_AURORA                     ".AUR"                      // ATI BIOS string to detect Aurora
#define BIOS_STRING_LENGTH              43                          // Max length of ATI BIOS P/N string
#define ADAPTER_STRING_LENGTH           45                          // Max length of Adapter ID

/* ### EOF ### */


--Multipart_Sat__8_Feb_2003_15:08:40_+0100_096e6060--
